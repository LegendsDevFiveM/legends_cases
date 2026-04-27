import { useState, useEffect, useRef } from 'react'
import { itemImage, onItemImageError } from '../utils/itemImage.js'
import { getRarity } from '../utils/rarities.js'

const FINAL_TOP_VH   = 14
const CARD_SIZE      = 260
const RISE_DURATION  = 850

export default function WinModal({ winner, originY, onClose }) {
  const rarity = getRarity(winner.rarity)
  const cardRef = useRef(null)

  const [riseTransform, setRiseTransform] = useState(() => {
    const finalCenterY = (FINAL_TOP_VH / 100) * window.innerHeight + CARD_SIZE / 2
    const offsetY = (originY || finalCenterY) - finalCenterY
    return `translateY(${offsetY}px) scale(0.68)`
  })

  useEffect(() => {
    const id = requestAnimationFrame(() => {
      setRiseTransform('translateY(0) scale(1)')
    })
    return () => cancelAnimationFrame(id)
  }, [])

  return (
    <div
      className="fixed inset-0 z-50 flex justify-center cursor-pointer"
      onClick={onClose}
      style={{ paddingTop: `${FINAL_TOP_VH}vh` }}
    >
      <div className="relative" style={{ width: CARD_SIZE, height: CARD_SIZE }}>
        <div
          className="absolute inset-0 rounded-full pointer-events-none animate-glow-pulse"
          style={{
            background: `radial-gradient(closest-side, ${rarity.color}66, transparent 70%)`,
            filter: 'blur(20px)',
            transform: 'scale(1.6)',
          }}
        />

        <div
          ref={cardRef}
          className="relative w-full h-full rounded-lg overflow-hidden flex flex-col items-center justify-center
                     bg-gradient-to-b from-white/[0.04] to-white/[0.01]
                     border border-white/10"
          style={{
            transform: riseTransform,
            transition: `transform ${RISE_DURATION}ms cubic-bezier(0.16, 1, 0.3, 1)`,
            boxShadow: `inset 0 -40px 60px -30px ${rarity.color}55, 0 0 60px ${rarity.color}55`,
          }}
        >
          <div className="flex-1 w-full flex items-center justify-center px-4 pt-3 min-h-0">
            <img
              src={itemImage(winner.item)}
              alt={winner.item}
              onError={onItemImageError}
              className="max-h-[140px] max-w-[180px] object-contain animate-win-pulse"
              style={{
                filter: `drop-shadow(0 0 18px ${rarity.color})`,
              }}
              draggable={false}
            />
          </div>

          <div className="w-full text-center px-2 pb-3">
            <div className="text-[12px] uppercase tracking-wider text-white/80 truncate">
              {winner.item}
            </div>
            {winner.count > 1 && (
              <div className="text-[11px] text-white/60 mt-0.5">x{winner.count}</div>
            )}
          </div>

          <div
            className="absolute bottom-0 left-0 right-0 h-[5px]"
            style={{
              background: rarity.color,
              boxShadow: `0 0 14px ${rarity.color}cc`,
            }}
          />
        </div>
      </div>

      <div
        className="absolute left-0 right-0 text-center text-[11px] uppercase tracking-[0.4em] text-white/60 animate-hint-pulse"
        style={{ bottom: '12vh' }}
      >
        Click anywhere to continue
      </div>
    </div>
  )
}
