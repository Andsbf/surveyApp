import React, { Component } from 'react'
import { connect } from 'react-redux'
import Editing from '../components/Editing'
import FormList from './FormList'
import { fetchForms } from '../actions/forms'
import { selectForm } from '../actions/form'
import { mapObject } from '../utils/objectHelpers'

class App extends Component {

  render() {
    const {
      selectedForm
    } = this.props

    return(
      <div>
        <FormList/>
        { selectedForm ? <Editing/> : '' }
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  const selectedForm = state.globalState.selectedForm;
  return {
    selectedForm
  };
}

App = connect(mapStateToProps)(App);

export default App

