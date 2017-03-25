import React, { PropTypes } from 'react';
import PhotoBox from './PhotoBox';
import FullPhotoBox from './FullPhotoBox';

export default class ListPhotoBox extends React.Component {
    constructor(props) {
        super(props);
    }

    detailComponent() {
        if (this.props.general.is_show) {
            return <FullPhotoBox detail={this.props.detail} general={this.props.general} actions={this.props.actions} />;
        } else {
            return null;
        }
    }

    componentDidMount() { 
        $.getJSON("foto/user", (response) => { 
            this.props.actions.setUser(response);
        });
    }

    render() {
        var photoItems = this.props.photo.datas.map((data,index) =>
            <PhotoBox key={index} data={data} general={this.props.general} actions={this.props.actions} />
        );
        
        return ( 
            <div className="row">
                {this.detailComponent()} 
                {photoItems}
            </div>
        ) 
    }
}

ListPhotoBox.propTypes= {
    photo: PropTypes.object.isRequired,
    detail: PropTypes.object.isRequired,
    general: PropTypes.object.isRequired,
    actions: PropTypes.object.isRequired,
};
