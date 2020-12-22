import React from 'react'
// import {useHistory} from 'react-router-dom'
import {
    useTheme,
    createStyles,
    makeStyles,
    Theme,
} from '@material-ui/core/styles'

// import {Toolbar, AppBar, IconButton} from '@material-ui/core'
import {Toolbar, AppBar} from '@material-ui/core'

const useStyles = makeStyles((theme: Theme) =>
    createStyles({
        appBar: {boxShadow: 'none', backgroundColor: 'transparent'},
        menuButton: {
            marginRight: theme.spacing(2),
        },
        spacer: {
            flexGrow: 1,
        },
    })
)

export interface HeaderProps {
}

const Header: React.FunctionComponent<HeaderProps> = () => {
    const classes = useStyles(useTheme())
    // const history = useHistory()

    return (
        <AppBar position="static" className={classes.appBar}>
            <Toolbar />
        </AppBar>
    )
}

export default Header
