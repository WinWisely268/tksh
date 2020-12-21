import React, {Suspense} from 'react'
import ReactDOM from 'react-dom'
import {BrowserRouter} from 'react-router-dom'
import App from './app/App'
import reportWebVitals from './reportWebVitals'
import {CircularProgress} from '@material-ui/core'
import * as serviceWorker from './service-worker'

const app = (
    <BrowserRouter>
        <Suspense fallback={CircularProgress}>
            <App/>
        </Suspense>
    </BrowserRouter>
)

ReactDOM.render(
    app,
    document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals

reportWebVitals();

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister()

