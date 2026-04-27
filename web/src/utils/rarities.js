export const RARITIES = {
  milspec:    { label: 'Mil-Spec',      color: '#4b69ff', tw: 'rarity-milspec',    sound: 'winCommon' },
  restricted: { label: 'Restricted',    color: '#8847ff', tw: 'rarity-restricted', sound: 'winCommon' },
  classified: { label: 'Classified',    color: '#d32ce6', tw: 'rarity-classified', sound: 'winRare'   },
  covert:     { label: 'Covert',        color: '#eb4b4b', tw: 'rarity-covert',     sound: 'winRare'   },
  gold:       { label: 'Extraordinary', color: '#ffd700', tw: 'rarity-gold',       sound: 'winGold'   },
}

export function getRarity(key) {
  return RARITIES[key] || RARITIES.milspec
}
