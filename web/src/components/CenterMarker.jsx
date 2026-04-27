export default function CenterMarker() {
  return (
    <>
      <div className="pointer-events-none absolute top-0 left-1/2 -translate-x-1/2 z-30">
        <div
          className="w-0 h-0"
          style={{
            borderLeft:  '10px solid transparent',
            borderRight: '10px solid transparent',
            borderTop:   '14px solid #ffffff',
            filter: 'drop-shadow(0 0 6px rgba(235, 75, 75, 0.9))',
          }}
        />
      </div>

      <div
        className="pointer-events-none absolute top-2 bottom-2 left-1/2 -translate-x-1/2 w-[3px] z-30
                   rounded-full animate-marker-glow"
        style={{
          background: 'linear-gradient(180deg, #ffffff 0%, #eb4b4b 50%, #ffffff 100%)',
        }}
      />

      <div className="pointer-events-none absolute bottom-0 left-1/2 -translate-x-1/2 z-30">
        <div
          className="w-0 h-0"
          style={{
            borderLeft:   '10px solid transparent',
            borderRight:  '10px solid transparent',
            borderBottom: '14px solid #ffffff',
            filter: 'drop-shadow(0 0 6px rgba(235, 75, 75, 0.9))',
          }}
        />
      </div>
    </>
  )
}
