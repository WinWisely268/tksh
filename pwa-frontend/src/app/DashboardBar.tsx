import React, { useState } from 'react'
import {
  Drawer,
  Toolbar,
  AppBar,
  Typography,
  Divider,
  IconButton
} from '@material-ui/core'
import HomeIcon from '@material-ui/icons/Home'
import MenuIcon from '@material-ui/icons/Menu'
import ChevronLeftIcon from '@material-ui/icons/ChevronLeft'
import cx from 'classnames'
import * as H from 'history'
import { useStyles } from './DashboardLayout'

export interface DashboardBarProps {
  drawerWidth: number
  history: H.History<H.LocationState>
}

const DashboardBar: React.FunctionComponent<DashboardBarProps> = ({
  drawerWidth,
  history
}) => {
  const [open, setOpen] = useState(false)
  const classes = useStyles()

  const handleDrawerOpen = () => {
    setOpen(true)
  }
  const handleDrawerClose = () => {
    setOpen(false)
  }

  return (
    <React.Fragment>
      <AppBar
        position='absolute'
        className={cx(classes.appBar, open && classes.appBarShift)}
      >
        <Toolbar className={classes.toolbar}>
          <IconButton
            edge='start'
            color='inherit'
            aria-label='open drawer'
            onClick={handleDrawerOpen}
            className={cx(classes.menuButton, open && classes.menuButtonHidden)}
          >
            <MenuIcon />
          </IconButton>
          <Typography
            component='h1'
            variant='h6'
            color='inherit'
            noWrap
            className={classes.title}
          >
            Laporan Kaca Sentrum 2020
          </Typography>
          <div className={classes.actions}>
            <IconButton
              edge='start'
              className={classes.menuButton}
              onClick={() => history.push('/')}
              color='inherit'
              aria-label='home'
            >
              <HomeIcon />
            </IconButton>
          </div>
        </Toolbar>
      </AppBar>
      <Drawer
        variant='temporary'
        classes={{
          paper: cx(classes.drawerPaper, !open && classes.drawerPaperClose)
        }}
        open={open}
      >
        <div className={classes.sidebarHeader}>
          <Typography
            component='h2'
            variant='h6'
            color='inherit'
            noWrap
            className={classes.sidebarTitle}
          >
            Kaca Menu
          </Typography>
          <IconButton onClick={handleDrawerClose}>
            <ChevronLeftIcon />
          </IconButton>
        </div>
        <Divider />
      </Drawer>
    </React.Fragment>
  )
}

export default DashboardBar
