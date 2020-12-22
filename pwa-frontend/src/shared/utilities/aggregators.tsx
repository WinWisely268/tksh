// Aggregators utilities for tables
import React from 'react'
import { Button, InputLabel, MenuItem, TextField } from '@material-ui/core'
import { FilterProps, FilterValue, IdType, Row } from 'react-table'

export function roundedMedian(values: any[]) {
  let min = values[0] || ''
  let max = values[0] || ''
  values.forEach((v) => {
    min = Math.min(min, v)
    max = Math.max(max, v)
  })
  return Math.round((min + max) / 2)
}

// id can be any field
export function filterGt(
  rows: Array<Row<any>>,
  id: Array<IdType<any>>,
  filterValue: FilterValue
) {
  return rows.filter((row) => {
    const rowValue = row.values[id[0]]
    return rowValue >= filterValue
  })
}

filterGt.autoRemove = (val: any) => typeof val !== 'number'

export function getMinMax<T extends object>(rows: Row<T>[], id: IdType<T>) {
  let min = rows.length ? rows[0].values[id] : 0
  let max = rows.length ? rows[0].values[id] : 0
  rows.forEach((row) => {
    min = Math.min(row.values[id], min)
    max = Math.max(row.values[id], max)
  })
  return [min, max]
}

export function SelectColumnFilter<T extends object>({
  column: { filterValue, render, setFilter, preFilteredRows, id }
}: FilterProps<T>): JSX.Element {
  const options = React.useMemo(() => {
    const options = new Set<any>()
    preFilteredRows.forEach((row) => {
      options.add(row.values[id])
    })
    return [...Array.from(options.values())]
  }, [id, preFilteredRows])

  return (
    <TextField
      select
      label={render('Header')}
      value={filterValue || ''}
      onChange={(e) => {
        setFilter(e.target.value || undefined)
      }}
    >
      <MenuItem value={''}>All</MenuItem>
      {options.map((option, i) => (
        <MenuItem key={i} value={option}>
          {option}
        </MenuItem>
      ))}
    </TextField>
  )
}

export function SliderColumnFilter<T extends object>({
  column: { render, filterValue, setFilter, preFilteredRows, id }
}: FilterProps<T>) {
  const [min, max] = React.useMemo(() => getMinMax(preFilteredRows, id), [
    id,
    preFilteredRows
  ])

  return (
    <div
      style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'baseline'
      }}
    >
      <TextField
        name={id}
        label={render('Header')}
        type='range'
        inputProps={{
          min,
          max
        }}
        value={filterValue || min}
        onChange={(e) => {
          setFilter(parseInt(e.target.value, 10))
        }}
      />
      <Button
        variant='outlined'
        style={{ width: 60, height: 36 }}
        onClick={() => setFilter(undefined)}
      >
        Off
      </Button>
    </div>
  )
}

export const useActiveElement = () => {
  const [active, setActive] = React.useState(document.activeElement)

  const handleFocusIn = () => {
    setActive(document.activeElement)
  }

  React.useEffect(() => {
    document.addEventListener('focusin', handleFocusIn)
    return () => {
      document.removeEventListener('focusin', handleFocusIn)
    }
  }, [])

  return active
}

// This is a custom UI for our 'between' or number range
// filter. It uses two number boxes and filters rows to
// ones that have values between the two
export function NumberRangeColumnFilter<T extends object>({
  column: { filterValue = [], render, preFilteredRows, setFilter, id }
}: FilterProps<T>) {
  const [min, max] = React.useMemo(() => getMinMax(preFilteredRows, id), [
    id,
    preFilteredRows
  ])
  const focusedElement = useActiveElement()
  const hasFocus =
    focusedElement &&
    (focusedElement.id === `${id}_1` || focusedElement.id === `${id}_2`)
  return (
    <>
      <InputLabel htmlFor={id} shrink focused={!!hasFocus}>
        {render('Header')}
      </InputLabel>
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'baseline',
          paddingTop: 5
        }}
      >
        <TextField
          id={`${id}_1`}
          value={filterValue[0] || ''}
          type='number'
          onChange={(e) => {
            const val = e.target.value
            setFilter((old: any[] = []) => [
              val ? parseInt(val, 10) : undefined,
              old[1]
            ])
          }}
          placeholder={`Min (${min})`}
          style={{
            width: '70px',
            marginRight: '0.5rem'
          }}
        />
        to
        <TextField
          id={`${id}_2`}
          value={filterValue[1] || ''}
          type='number'
          onChange={(e) => {
            const val = e.target.value
            setFilter((old: any[] = []) => [
              old[0],
              val ? parseInt(val, 10) : undefined
            ])
          }}
          placeholder={`Max (${max})`}
          style={{
            width: '70px',
            marginLeft: '0.5rem'
          }}
        />
      </div>
    </>
  )
}
