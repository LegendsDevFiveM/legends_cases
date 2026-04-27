const BASE = 'https://cfx-nui-ox_inventory/web/images'

export function itemImage(name) {
  if (!name) return ''
  return `${BASE}/${name}.png`
}

export function onItemImageError(e) {
  e.currentTarget.style.visibility = 'hidden'
}
