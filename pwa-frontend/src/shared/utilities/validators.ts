export const DEBOUNCE_TIME = 200

export const validateName = (val: string): boolean => {
  return /^[a-zA-Z\s]+$/.test(val)
}
