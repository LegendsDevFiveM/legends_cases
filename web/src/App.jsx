import { useState, useEffect, useCallback } from 'react'
import { useNuiEvent } from './hooks/useNuiEvent.js'
import { fetchNui } from './utils/fetchNui.js'
import CaseOpener from './components/CaseOpener.jsx'

export default function App() {
  const [visible, setVisible] = useState(false)
  const [payload, setPayload] = useState(null)

  useNuiEvent('openCase', (data) => {
    setPayload(data)
    setVisible(true)
  })

  useNuiEvent('close', () => {
    setVisible(false)
    setPayload(null)
  })

  const handleClose = useCallback(() => {
    setVisible(false)
    setPayload(null)
    fetchNui('finished')
  }, [])

  useEffect(() => {
    const onKey = (e) => {
      if (e.key === 'Escape') {
        e.preventDefault()
      }
    }
    window.addEventListener('keydown', onKey)
    return () => window.removeEventListener('keydown', onKey)
  }, [])

  if (!visible || !payload) return null

  return (
    <div
      className="fixed inset-0 flex items-center justify-center animate-fade-in"
      style={{
        backgroundColor: 'rgba(0, 0, 0, 0.75)',
      }}
    >
      <CaseOpener payload={payload} onFinished={handleClose} />
    </div>
  )
}
