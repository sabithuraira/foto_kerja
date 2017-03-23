import React, { PropTypes } from 'react';

export default class FormBox extends React.Component {
    constructor(props, _railsContext) {
        super(props);
    }

    render() {
        return ( 
            <div className="col-sm-4 col-lg-4 col-md-4">
                <div className="thumbnail">
                    <div className="thumbnailimg">
                        <img src={"media/"+this.props.data.file_name} alt={this.props.data.description} />
                    </div>
                    <div className="caption">
                        <b><a href="#">{this.props.data.user_name}</a></b>
                        <p>{this.props.data.description}</p>
                    </div>
                    <div className="ratings">
                        <p className="pull-right">15 komentar</p>
                        <p>
                            <span className="glyphicon glyphicon-heart"></span>
                            <b>15</b>
                        </p>
                    </div>
                </div>
            </div>
        ) 
    }
}