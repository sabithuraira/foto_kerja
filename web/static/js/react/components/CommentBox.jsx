import React, { PropTypes } from 'react';

export default class CommentBox extends React.Component {

    render() {
        var commentItems = this.props.comments.map((comment,index) =>
            <li  key={index}>
                <div className="commentText">
                    <p className="">
                        <b>{comment.user_name}</b> {comment.description}
                    </p>
                    <span className="date sub-text">on {comment.inserted_at}</span>
                </div>
            </li>
        );
        
        return ( 
            <div className="detailBox">
                <div className="actionBox">
                    <ul className="commentList">
                        {commentItems}
                    </ul>
                </div>
            </div>
        ) 
    }
}

CommentBox.propTypes= {
    comments: PropTypes.array.isRequired
};