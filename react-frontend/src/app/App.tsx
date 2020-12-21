import React from 'react';
import { Route, Switch } from 'react-router-dom';

import Home from './Home'

export interface AppProps { }

const App: React.FunctionComponent<AppProps> = () => {
  return (
    <Switch>
      <Route exact path='/' component={Home} />
    </Switch>
  )
}

export default App
