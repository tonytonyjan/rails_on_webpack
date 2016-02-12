import '../stylesheets/application.scss'
import '../images/tony.png'
import './coffee.coffee'
import React from 'react'
import ReactDOM from 'react-dom'
import Button from '../components/button'

var props = {name: "Hello React"} // Attribute spreading
ReactDOM.render(<Button {...props} />, document.getElementById('button'))