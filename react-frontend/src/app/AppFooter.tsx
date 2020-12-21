import React from 'react'

import Typography from '@material-ui/core/Typography'
import Container from '@material-ui/core/Container'
import Link from '@material-ui/core/Link'
import {
  useTheme,
  createStyles,
  makeStyles,
  Theme
} from '@material-ui/core/styles'

function Copyright() {
  return (
    <Typography variant='body2' color='textSecondary' align='center'>
      {'Perbaikan™ '}
      <Link
        color='inherit'
        href='https://perbaikankaca.fly.dev'>
          Perbaikan Kaca
      </Link>{' '}
      {new Date().getFullYear()}
    </Typography>
  )
}

const useStyles = makeStyles((theme: Theme) =>
  createStyles({
    footer: {
      padding: theme.spacing(2),
      marginTop: 'auto',
      backgroundColor: '#f6f6f6'
    }
  })
)

export interface FooterProps { }

const Footer: React.FunctionComponent<FooterProps> = () => {
  const classes = useStyles(useTheme())
  return (
    <footer className={classes.footer}>
      <Container maxWidth='sm'>
        <Copyright />
      </Container>
    </footer>
  )
}

export default Footer
