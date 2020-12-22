import React from 'react'
import { Route, Switch } from 'react-router-dom'

import Home from './Home'
import ServiceWorkerWrapper from '../components/SWWrapper'

export interface AppProps {
}

const App: React.FunctionComponent<AppProps> = () => {
  return (
    <div>
      <ServiceWorkerWrapper />
      <Switch>
        <Route exact path='/' component={Home} />
      </Switch>
    </div>
  )
}

export default App
