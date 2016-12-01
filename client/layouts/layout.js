import React from 'react'
import Navigation from 'layouts/navigation'

export default class Layout extends React.Component {
  render() {
    return (
      <div className='outer-container'>
        <Navigation />
        <section className='container' id='content'>
          {this.props.children}
        </section>
        <footer/>
      </div>
    )
  }
}
