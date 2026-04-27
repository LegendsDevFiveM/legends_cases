import { useEffect, useRef } from 'react'

export function useNuiEvent(action, handler) {
  const savedHandler = useRef(handler)

  useEffect(() => {
    savedHandler.current = handler
  }, [handler])

  useEffect(() => {
    const listener = (event) => {
      if (event.data?.action === action) {
        savedHandler.current(event.data.data)
      }
    }
    window.addEventListener('message', listener)
    return () => window.removeEventListener('message', listener)
  }, [action])
}
