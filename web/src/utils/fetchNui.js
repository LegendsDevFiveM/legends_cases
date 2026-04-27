export async function fetchNui(eventName, data) {
  try {
    const resp = await fetch(`https://legends_cases/${eventName}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json; charset=UTF-8' },
      body: JSON.stringify(data ?? {}),
    })
    const text = await resp.text()
    if (!text) return null
    try { return JSON.parse(text) } catch { return text }
  } catch (e) {
    return null
  }
}
