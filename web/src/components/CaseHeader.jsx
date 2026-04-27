export default function CaseHeader({ label }) {
  return (
    <div className="flex flex-col items-center text-center">
      <div className="text-[11px] uppercase tracking-[0.4em] text-white/40 mb-1">
        Opening
      </div>
      <h1 className="text-3xl font-extrabold tracking-wide text-white drop-shadow-[0_2px_8px_rgba(0,0,0,0.9)]">
        {label}
      </h1>
    </div>
  )
}
