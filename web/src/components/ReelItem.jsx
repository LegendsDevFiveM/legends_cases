import { itemImage, onItemImageError } from '../utils/itemImage.js'
import { getRarity } from '../utils/rarities.js'

export default function ReelItem({ entry }) {
  const rarity = getRarity(entry.rarity)
  return (
    <div
      className="relative aspect-square rounded-lg overflow-hidden flex flex-col items-center justify-center
                 bg-gradient-to-b from-white/[0.04] to-white/[0.01]
                 border border-white/10"
      style={{
        boxShadow: `inset 0 -30px 50px -25px ${rarity.color}55`,
      }}
    >
      <div className="flex-1 w-full flex items-center justify-center px-3 pt-2 min-h-0">
        <img
          src={itemImage(entry.item)}
          alt={entry.item}
          onError={onItemImageError}
          className="max-h-[80px] max-w-[110px] object-contain drop-shadow-[0_4px_12px_rgba(0,0,0,0.6)]"
          draggable={false}
        />
      </div>

      <div className="w-full text-center px-2 pb-2">
        <div className="text-[10px] uppercase tracking-wider text-white/60 truncate">
          {entry.item}
        </div>
        {entry.count > 1 && (
          <div className="text-[9px] text-white/50 mt-0.5">x{entry.count}</div>
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
  )
}
