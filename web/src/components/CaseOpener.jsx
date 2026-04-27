import { useState, useEffect, useRef, useCallback } from 'react'
import Reel from './Reel.jsx'
import CenterMarker from './CenterMarker.jsx'
import WinModal from './WinModal.jsx'
import { getRarity } from '../utils/rarities.js'

const SPIN_BASE_MS   = 6500
const SPIN_RANDOM_MS = 15000
const REVEAL_DELAY   = 600

export const ITEM_WIDTH = 192
export const ITEM_GAP   = 0

const SOUNDS = {
  open:       './sounds/case_open.ogg',
  tick:       './sounds/tick.ogg',
  winCommon:  './sounds/win_common.ogg',
  winRare:    './sounds/win_rare.ogg',
  winGold:    './sounds/win_gold.ogg',
}

function easeOutQuint(t) {
  return 1 - Math.pow(1 - t, 5)
}

function winSoundFor(rarity) {
  const key = getRarity(rarity).sound
  return SOUNDS[key] || SOUNDS.winCommon
}

function playSound(src, volume = 1.0) {
  try {
    const audio = new Audio(src)
    audio.volume = volume
    const p = audio.play()
    if (p && typeof p.catch === 'function') p.catch(() => {})
  } catch {}
}

export default function CaseOpener({ payload, onFinished }) {
  const { strip, winningIndex, winner } = payload

  const winIdx0 = Math.max(0, (winningIndex || 1) - 1)

  const viewportRef = useRef(null)
  const [translateX, setTranslateX] = useState(0)
  const [phase, setPhase] = useState('idle')
  const [originY, setOriginY] = useState(0)
  const [spinDuration] = useState(() => SPIN_BASE_MS + Math.random() * SPIN_RANDOM_MS)

  useEffect(() => {
    const viewport = viewportRef.current
    if (!viewport) return

    const W = viewport.getBoundingClientRect().width
    const winnerCenterX = (winIdx0 + 0.5) * ITEM_WIDTH
    const jitter = (Math.random() - 0.5) * (ITEM_WIDTH * 0.8)
    const target = winnerCenterX - W / 2 + jitter

    requestAnimationFrame(() => {
      setPhase('spinning')
      setTranslateX(target)
      playSound(SOUNDS.open, 0.9)
    })

    const start = performance.now()
    let lastCrossings = 0
    let rafId = 0
    const tickLoop = () => {
      const elapsed = performance.now() - start
      const t = Math.min(1, elapsed / spinDuration)
      const eased = easeOutQuint(t)
      const currentX = eased * target
      const crossings = Math.floor(currentX / ITEM_WIDTH)
      if (crossings > lastCrossings) {
        playSound(SOUNDS.tick, 0.55)
        lastCrossings = crossings
      }
      if (t < 1) {
        rafId = requestAnimationFrame(tickLoop)
      }
    }
    rafId = requestAnimationFrame(tickLoop)
    return () => cancelAnimationFrame(rafId)
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const handleTransitionEnd = useCallback(() => {
    if (phase !== 'spinning') return
    setPhase('revealing')
    const t1 = setTimeout(() => {
      const rect = viewportRef.current?.getBoundingClientRect()
      if (rect) setOriginY(rect.top + rect.height / 2)
      setPhase('won')
      playSound(winSoundFor(winner?.rarity), 0.95)
    }, REVEAL_DELAY)
    return () => clearTimeout(t1)
  }, [phase, winner])

  return (
    <div className="relative flex flex-col items-center w-[1100px] max-w-[95vw] animate-rise-in">
      <div
        ref={viewportRef}
        className="relative w-full h-[210px] overflow-hidden"
        style={{
          maskImage: 'linear-gradient(to right, transparent 0%, black 19%, black 81%, transparent 100%)',
          WebkitMaskImage: 'linear-gradient(to right, transparent 0%, black 19%, black 81%, transparent 100%)',
        }}
      >

        <Reel
          strip={strip}
          translateX={translateX}
          duration={spinDuration}
          itemWidth={ITEM_WIDTH}
          onTransitionEnd={handleTransitionEnd}
        />

        <CenterMarker />
      </div>

      {phase === 'won' && winner && (
        <WinModal winner={winner} originY={originY} onClose={onFinished} />
      )}
    </div>
  )
}
