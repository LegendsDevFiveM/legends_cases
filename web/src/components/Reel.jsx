import ReelItem from './ReelItem.jsx'

export default function Reel({ strip, translateX, duration, itemWidth, onTransitionEnd }) {
  return (
    <div
      className="reel-strip absolute top-0 left-0 h-full flex items-center"
      style={{
        transform: `translate3d(${-translateX}px, 0, 0)`,
        transition: `transform ${duration}ms cubic-bezier(0.22, 1, 0.36, 1)`,
      }}
      onTransitionEnd={onTransitionEnd}
    >
      {strip.map((entry, i) => (
        <div key={i} style={{ width: itemWidth, flexShrink: 0 }} className="px-2">
          <ReelItem entry={entry} />
        </div>
      ))}
    </div>
  )
}
