import React, { PropTypes } from 'react';
import CommentBox from './CommentBox';

export default class FullPhotoBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            description: '',
        }

        this.closeClick = this.closeClick.bind(this);
        this.postComment = this.postComment.bind(this);
        this.handleInputChange = this.handleInputChange.bind(this);
        this.sukaClick = this.sukaClick.bind(this);
    }

    closeClick(event) { this.props.actions.showDetail(false); }

    handleInputChange(event) {
        this.setState({ description: event.target.value });
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
                foto_id: this.props.detail.data.id,
                user_id: this.props.general.login_id,
            },
            success: function(data) {
                $.getJSON("/suka/"+this.props.detail.data.id, (response) => {
                    this.props.actions.setSuka(this.props.detail.data.id, data);
                    this.props.actions.setLabelSuka(response);
                }); 
                //this.props.actions.setSuka(this.props.detail.data.id, data);
            }.bind(this),
            error: function(xhr, status, err) {
                alert('Ooops, terjadi kesalahan.. silahkan ulangi lagi!');
                console.log(xhr.responseText)
            }.bind(this)
        });
    }

    postComment(event) { 
        var is_change=false;

        if(event.type=="keypress" && event.key=='Enter') is_change=true
        if(event.type=="click") is_change=true;

        if(is_change){
            var csrf = document.querySelector("meta[name=csrf]").content;
            $.ajax({
                url: "komentar/",
                dataType: 'json',
                type: 'POST',
                headers: {
                    "X-CSRF-TOKEN": csrf 
                },
                data: {
                    description: this.state.description,
                    foto_id: this.props.detail.data.id,
                    user_id: this.props.general.login_id,
                },
                success: function(data) {
                    this.setState({ description: '' });
                    this.props.actions.addComment(data);
                }.bind(this),
                error: function(xhr, status, err) {
                    alert('Ooops, terjadi kesalahan.. silahkan ulangi lagi!');
                }.bind(this)
            });
        }
    }

    componentDidMount() { 
        $.getJSON("komentar/foto/"+this.props.detail.data.id, (response) => { 
            this.props.actions.listComment(response.data);
        });

        var img = document.getElementById('full-img');
        img.onload = function() {
            if(img.height > img.width) {
                img.style.height = '350px';
                img.style.width = 'auto';
            }
            else{
                img.style.width = "525px";
                img.style.height = "auto";
            }

            var img_height;

            if(img.offsetHeight) {
                img_height=img.offsetHeight;

            } else if(img.style.pixelHeight) {
                img_height=img.style.pixelHeight;
            }

            img_height-=57;
            var capt = document.getElementById('full-capt');
            capt.style.height=img_height+"px";
        };
    }

    commentBoxComponent() {
        if (this.props.general.login_id!=0) {
            return (<div className="input-group nav-form">
                        <input type="text" className="form-control"
                            value={this.state.description}
                            onChange={this.handleInputChange}
                            onKeyPress={this.postComment}
                            placeholder="Komentar anda.." />
                        <div className="input-group-btn">
                            <button className="btn btn-default" type="button" onClick={this.postComment} >
                                <i className="glyphicon glyphicon-floppy-disk"></i>
                            </button>
                        </div>
                    </div>);
        } else {
               return (<div className="alert alert-info" role="alert">
                        Silahkan login untuk menulis komentar
                        </div>
               );
        }
    }

    render() {
        return ( 
            <div className="modal show" tabIndex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div className="modal-dialog modal-lg" role="document">
                    <div className="modal-content">
                        <div className="modal-header">
                            <button  onClick={this.closeClick} type="button" className="close"><span aria-hidden="true">&times;</span></button>
                            {this.props.detail.data.unit_kerja} - {this.props.detail.data.kegiatan}
                        </div>
                        
                        <div className="modal-body">
                            <div className="row">
                                <div className="media">
                                    <div className="media-left">
                                        <img id="full-img" className="mediaimg" src={"media/"+this.props.detail.data.file_name} alt={this.props.detail.data.description} />
                                    </div>
                                    <div className="media-body">
                                        <b>{this.props.detail.data.user_name}</b>
                                        <div  id="full-capt" className="detail-caption">
                                            <p>{this.props.detail.data.description}</p>
                                            <div className="ratings">
                                                <p>
                                                    <span onClick={this.sukaClick}  className="glyphicon glyphicon-heart"></span> {this.props.detail.data.label_like}
                                                </p>
                                            </div>
                                            
                                            <CommentBox comments={this.props.detail.comments} />
                                        </div>

                                        {this.commentBoxComponent()}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        ) 
    }
}

FullPhotoBox.propTypes= {
    detail: PropTypes.object.isRequired,
    general: PropTypes.object.isRequired,
    actions: PropTypes.object.isRequired,
};