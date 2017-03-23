import React, { PropTypes } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import ListPhotoBox from '../components/ListPhotoBox';
import SearchBox from '../components/SearchBox';
import * as appActions from '../actions/appActionCreators';

const App = ({photoReducer, detailReducer, actions}) => (
  <div>
    <SearchBox actions={actions} />
    <ListPhotoBox  actions={actions} photo={photoReducer} detail={detailReducer} />
  </div>
)

App.propTypes = {
    photoReducer: PropTypes.object.isRequired,
    detailReducer: PropTypes.object.isRequired,
    actions: PropTypes.object.isRequired
}

const mapStateToProps = (state) => ({
    photoReducer: state.photoReducer,
    detailReducer: state.detailReducer
});


const mapDispatchToProps = (dispatch) => ({
    actions: bindActionCreators(appActions, dispatch)
});

export default connect(mapStateToProps, mapDispatchToProps)(App);
