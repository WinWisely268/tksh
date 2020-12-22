export const DEBOUNCE_TIME = 200

export const validateName = (val: string): boolean => {
  const isValid = /^[a-zA-Z\s]+$/.test(val)
  return isValid
}

export const validateEmail = (val: string): boolean => {
  // return /^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[A-Za-z]+$/.test(val)
  return /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/.test(val)
}

export const validateGovtId = (val: string): boolean => {
  return /^[0-9]{16}$/.test(val)
}
