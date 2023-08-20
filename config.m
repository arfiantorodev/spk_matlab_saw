host = 'localhost'; % isi dengan host, misal : localhost
user = 'root'; % isi dengan user, misal : root
password = ''; % isi dengan password, misal : iloveyou
dbName = 'db_spk_matlab_saw'; % isi dengan nama database, misal : databaseku

% Parameters JDBC
jdbcString = sprintf('jdbc:mysql://%s/%s', host, dbName);
jdbcDriver = 'com.mysql.jdbc.Driver';
 
% Buat Koneksi Database
dbConn = database(dbName, user , password, jdbcDriver, jdbcString);