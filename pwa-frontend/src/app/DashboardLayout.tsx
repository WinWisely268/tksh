import React from 'react'
import {CssBaseline} from '@material-ui/core'
import DashboardBar from './DashboardBar'
import {useHistory} from 'react-router-dom'
import {
    useTheme,
    createStyles,
    makeStyles,
    Theme
} from '@material-ui/core/styles'

const drawerWidth = 240

export interface DashboardLayoutProps {
    children?: any
}

export const useStyles = makeStyles((theme: Theme = useTheme()) =>
    createStyles({
        root: {
            display: 'flex'
        },
        toolbar: {
            paddingRight: 24 // keep right padding when drawer closed
        },
        sidebarHeader: {
            display: 'flex',
            alignItems: 'center',
            // justifyContent: 'center',
            whiteSpace: 'nowrap',
            padding: '0 8px',
            ...theme.mixins.toolbar
        },
        appBar: {
            zIndex: theme.zIndex.drawer + 1,
            transition: theme.transitions.create(['width', 'margin'], {
                easing: theme.transitions.easing.sharp,
                duration: theme.transitions.duration.leavingScreen
            })
        },
        appBarShift: {
            marginLeft: drawerWidth,
            width: `calc(100% - ${drawerWidth}px)`,
            transition: theme.transitions.create(['width', 'margin'], {
                easing: theme.transitions.easing.sharp,
                duration: theme.transitions.duration.enteringScreen
            })
        },
        menuButton: {
            marginRight: 18
        },
        menuButtonHidden: {
            display: 'none'
        },
        title: {
            flexGrow: 1
        },
        centerContainer: {
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center'
        },
        drawerPaper: {
            position: 'relative',
            whiteSpace: 'nowrap',
            width: drawerWidth,
            transition: theme.transitions.create('width', {
                easing: theme.transitions.easing.sharp,
                duration: theme.transitions.duration.enteringScreen
            })
        },
        drawerPaperClose: {
            overflowX: 'hidden',
            transition: theme.transitions.create('width', {
                easing: theme.transitions.easing.sharp,
                duration: theme.transitions.duration.leavingScreen
            }),
            width: theme.spacing(7),
            [theme.breakpoints.up('sm')]: {
                width: theme.spacing(9)
            }
        },
        content: {
            // display: 'flex',
            paddingTop: '50px',
            height: '100vh',
            flexGrow: 1,
            overflow: 'auto'
        },
        appBarSpacer: {},
        container: {
            paddingTop: theme.spacing(4),
            paddingBottom: theme.spacing(4)
        },
        paper: {
            padding: theme.spacing(2),
            display: 'flex',
            overflow: 'auto',
            flexDirection: 'column'
        },
        fixedHeight: {
            height: 240
        },
        sidebarLogo: {
            paddingTop: '5px',
            height: '44px'
            // marginBottom: theme.spacing(1)
        },
        sidebarTitle: {
            flexGrow: 1,
            padding: '0px 22px'
        },
        actions: {
            marginLeft: 'auto',
            alignItems: 'center',
            display: 'flex'
        }
    })
)

const DashboardLayout: React.FunctionComponent<DashboardLayoutProps> = ({children}) => {
    const history = useHistory()
    const classes = useStyles()
    return (
        <div className={classes.root}>
            <CssBaseline/>
            <DashboardBar
                drawerWidth={drawerWidth}
                history={history}
            />
            <main className={classes.content}>
                <div className={classes.appBarSpacer}>
                        {children}
                </div>
            </main>
        </div>
    )
}

export default DashboardLayout
