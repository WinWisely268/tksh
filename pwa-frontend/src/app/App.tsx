import React, {lazy} from 'react'
import { Route, Switch } from 'react-router-dom'
const ServiceWorkerWrapper = lazy( () => import('../components/SWWrapper'))

const Home = lazy(() => import('./Home'))

export interface AppProps {}

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
