import React from 'react'
import classNames from 'classnames'

export default class Checkbox extends React.Component {
  state = { isChecked: this.props.isChecked }

  toggleCheckbox = () => {
    this.setState({ isChecked: !this.state.isChecked })
    this.props.handleCheckboxChange(this.props.modelId)
  }

  render() {
    let { label } = this.props
    let labelClassNames = classNames({
      'selected': this.state.isChecked,
      'eliminated': this.props.isEliminated
    })

    return (
      <label className={labelClassNames}>
        <input
          type='checkbox'
          value={label}
          checked={this.state.isChecked}
          onChange={this.toggleCheckbox}
        />
        {label}
      </label>
    )
  }
}
