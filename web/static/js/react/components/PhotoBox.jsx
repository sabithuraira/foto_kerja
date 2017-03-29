import React, { PropTypes } from 'react';

export default class PhotoBox extends React.Component {
    constructor(props) {
        super(props);
        this.handleClick = this.handleClick.bind(this);
        this.sukaClick = this.sukaClick.bind(this);
    }

    handleClick(event) {
        this.props.actions.showDetail(true);
        this.props.actions.setDetail(this.props.data);
    }

    sukaClick(event) {
        var csrf = document.querySelector("meta[name=csrf]").content;
         $.ajax({
            url: "suka/",
            dataType: 'json',
            type: 'POST',
            headers: {
                "X-CSRF-TOKEN": csrf 
            },
            data: {
                is_suka: 1,
                foto_id: this.props.data.id,
                user_id: this.props.general.login_id,
            },
            success: function(data) {

                $.getJSON("/suka/"+this.props.data.id, (response) => { 
                    this.props.actions.setSuka(this.props.data.id, data, response);
                }); 

            }.bind(this),
            error: function(xhr, status, err) {
                alert('Ooops, terjadi kesalahan.. silahkan ulangi lagi!');
                console.log(xhr.responseText)
            }.bind(this)
        });
    }

    render() {
        return ( 
            <div className="col-sm-4 col-lg-4 col-md-4">
                <div className="thumbnail">
                    <div className="thumbnailimg">
                        <img onClick={this.handleClick} src={"media/"+this.props.data.file_name} alt={this.props.data.description} />
                    </div>
                    <div className="caption">
                        <b><a href="#">{this.props.data.user_name}</a></b>
                        <p>{this.props.data.description}</p>
                    </div>
                    <div className="ratings">
                        <p className="pull-right">{this.props.data.total_komentar} komentar</p>
                        <p>
                            <span onClick={this.sukaClick} className="glyphicon glyphicon-heart"></span>
                            <b> {this.props.data.total_suka}</b>
                        </p>
                    </div>
                </div>
            </div>
        ) 
    }
}

PhotoBox.propTypes= {
    data: PropTypes.object.isRequired,
    general: PropTypes.object.isRequired,
    actions: PropTypes.object.isRequired,
};