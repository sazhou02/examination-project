const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cors = require('cors')
const cookieParser = require('cookie-parser');
const logger = require('morgan');
require('express-async-errors');

const { ipIntercept, limiter } = require('./ip-intercept');
const { validateAuth } = require('./auth');
const indexRouter = require('./routes/index');
const userRouter = require('./routes/user');
const relationshipRouter = require('./routes/relationship');
const packageRouter = require('./routes/package');
const adminRouter = require('./routes/admin');
const assignment = require('./routes/assignment');
const permission = require('./routes/permission');
const role = require('./routes/role');
const examination_center = require('./routes/examination_center');
const department_doctor = require('./routes/department_doctor');
const examination_order = require('./routes/examination_order');
const category = require('./routes/category');
const queue = require('./routes/queue');
const item = require('./routes/item');
const examination_result = require('./routes/examination_result');
const examinee = require('./routes/examinee');
const schedule = require('./routes/schedule');
const district = require('./routes/district');
const group_information = require('./routes/group_information');

const app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(cors());
app.use(ipIntercept); // 拦截黑名单内的ip，防止ddos攻击
app.use(limiter); //访问频率限制
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(validateAuth); //通过token验证用户是否有权访问，同时提取id

app.use('/', indexRouter);
app.use('/user', userRouter);
app.use('/relationship', relationshipRouter);
app.use('/package', packageRouter)
app.use('/admin', adminRouter);
app.use('/assignment', assignment);
app.use('/permission', permission);
app.use('/role', role);
app.use('/examination_center', examination_center);
app.use('/department_doctor', department_doctor);
app.use('/examination_order', examination_order);
app.use('/category', category);
app.use('/queue', queue);
app.use('/item', item);
app.use('/examination_result', examination_result);
app.use('/examinee', examinee);
app.use('/schedule', schedule);
app.use('/district', district);
app.use('/group', group_information);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  // render the error page
  res.status(err.status || 500);
  console.log(err)
  // res.render('error');
  res.send(err);
});

module.exports = app;
