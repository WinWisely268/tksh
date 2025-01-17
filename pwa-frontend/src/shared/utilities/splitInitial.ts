// eslint-disable-next-line import/no-anonymous-default-export
export default (name = '', separator = ' ') => name
  .replace(/\s+/, ' ')
  .split(separator)
  .slice(0, 2)
  .map((v) => v && v[0].toUpperCase())
  .join('')