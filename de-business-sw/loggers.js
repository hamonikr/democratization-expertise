const appRoot = require('app-root-path');
const winston = require('winston');
const process = require('process');

const { combine, timestamp, label, printf } = winston.format;

const myFormat = printf(({ level, message, label, timestamp }) => {
  return `${timestamp} [${label}] ${level}: ${message}`;
});

const options = {
  file: {
	  filename: '/tmp/log/hamonikr-vdi/vdi-session.log'
  },
  // filename : '/tmp/log/hamonikr-vdi/vdi-session.log'
  console: {
    level: 'debug',
    handleExceptions: true,
    json: false,
    colorize: true,
    format: combine(
      label({ label: 'express_server' }),
      timestamp(),
      myFormat
    )
  }
}

let logger = new winston.createLogger({
  transports: [
    new winston.transports.Console(options.console)
  ],
  exitOnError: false, // do not exit on handled exceptions
});


logger.stream = {
  write: function(message, encoding) {
    logger.info(message);
  },
};

module.exports = logger;
