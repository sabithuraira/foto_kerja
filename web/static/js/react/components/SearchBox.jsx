import React, { PropTypes } from 'react';

export default class SearchBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            src_term: ""
        };

        this.searchClick = this.searchClick.bind(this);
        this.handleInputChange = this.handleInputChange.bind(this);
    }
    
    componentDidMount() { 
        $.getJSON("/foto", (response) => {  //+this.state.items[0]['id'], (response) => { 
            this.props.actions.listPhoto("", response.data);
        }); 
    }

    handleInputChange(event) {
        this.setState({ src_term: event.target.value });
    }

    searchClick (event) {
        var is_change=false;

        if(event.type=="keypress" && event.key=='Enter') is_change=true
        if(event.type=="click") is_change=true;

        if(is_change){
            $.getJSON("/foto?src_term="+this.state.src_term, (response) => { 
                this.props.actions.listPhoto(this.state.src_term, response.data);
            });
        }
    };

    render() {
        return ( 
            <div className="row">
                <div className="col-md-1 col-sm-1 col-lg-1">
                    <div className="input-group nav-form">
                        <button type="button" className="btn btn-default">
                            <i className="glyphicon glyphicon-plus"></i>
                        </button>
                    </div>
                </div>

                <div className="col-md-11 col-sm-11 col-lg-11">
                    <div className="input-group nav-form">
                        <input type="text" className="form-control" 
                            value={this.state.src_term} 
                            onChange={this.handleInputChange}
                            onKeyPress={this.searchClick}
                            placeholder="Search" />
                        <div className="input-group-btn">
                            <button className="btn btn-default" type="button" onClick={this.searchClick}>
                                <i className="glyphicon glyphicon-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
        </div>
        ) 
    }
}

SearchBox.propTypes= {
    actions: PropTypes.object.isRequired,
};