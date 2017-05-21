var RugbyDictQuery = React.createClass({
  getInitialState() {
    return {
      translationInput: "",
      translationResult: ""
    };
  },
  handleTranslate() {
    $.getJSON('/api/v1/dict.json', {entry: this.state.translationInput}, (response) => { 
      this.setState({ translationResult: response.result.join(' ') }) 
    });
  },
  handleChange(event) {
    this.setState({translationInput: event.target.value});
  },
  render() {
    return (
      <div className="section">
        <div className="section-wrap">
          <div className="section-item">
            <div className="section-title">
              {this.props.title}
            </div>
            <div className="section-content">
              <input
                type="text"
                className="dict-input"
                value={this.state.translationInput}
                onChange={this.handleChange}
              />
              <button onClick={this.handleTranslate}>
                Translate
              </button>
            </div>
            <div className="section-content" id="translate-result">
              {this.state.translationResult}
            </div>
          </div>
        </div>
      </div>
    )
  }
});
