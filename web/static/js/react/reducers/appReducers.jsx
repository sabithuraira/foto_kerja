import { combineReducers } from 'redux';
import { 
  LIST_PHOTO, 
  SHOW_DETAIL, 
  SET_DETAIL,
  LIST_COMMENT,
  ADD_COMMENT,
  SET_USER } from '../constants/appConstants';

const initialState = {
    search_keyword: '',
    datas: [
        /*
        {label: "Pengolahan SE2017", deskripsi: "Lorem ipsum valar morgulis valar dohaeris"},
        {label: "Pengolahan SE2017", deskripsi: "Lorem ipsum valar morgulis valar dohaeris"},
        {label: "Pengolahan SE2017", deskripsi: "Lorem ipsum valar morgulis valar dohaeris"},
        {label: "Pengolahan SE2017", deskripsi: "Lorem ipsum valar morgulis valar dohaeris"},
        {label: "Pengolahan SE2017", deskripsi: "Lorem ipsum valar morgulis valar dohaeris"},
        {label: "Pengolahan SE2017", deskripsi: "Lorem ipsum valar morgulis valar dohaeris"},
        */
    ],
}

const photoReducer = (state = initialState, action) => {
  switch (action.type) {
    case LIST_PHOTO:
      return Object.assign({}, state, {
          search_keyword: action.search_keyword,
          datas: action.datas, 
      })
    default:
      return state
  }
}

const detailState = {
  is_show : false,
  data: {},
  comments: [],
  login_id: 0,
}

const detailReducer = (state = detailState, action) => {
  switch (action.type) {
    case SHOW_DETAIL:
      return Object.assign({}, state, {
          is_show: action.is_show,
      })
    case SET_DETAIL:
      return Object.assign({}, state, {
          data: action.data,
      })
    case LIST_COMMENT:
      return Object.assign({}, state, {
          comments: action.comments,
      })
    case ADD_COMMENT:
      console.log("masuk add comment");
      /*
      state.comments = [
          ...state.comments,
          action.comment
      ]

      console.log(JSON.stringify(state));
      return ...state
      */
      return Object.assign({}, state, {
          comments: [
            ...state.comments,
            action.comment
        ]
      })
    case SET_USER:
      return Object.assign({}, state, {
          login_id: action.login_id,
      })
    default:
      return state
  }
}

const appReducers = combineReducers({ 
  photoReducer,
  detailReducer
});
export default appReducers; 
