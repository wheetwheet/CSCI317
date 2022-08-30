import java.sql.*;

class solution3
{
  public static void main (String args [])
       throws SQLException, ClassNotFoundException
  {
   // Load the Oracle JDBC driver
    Class.forName ("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection
       ("jdbc:oracle:thin:@localhost:1521:db",  "tpchr", "oracle");
  try{
        System.out.println( "Connected to a database server" );
        System.out.println( );

	Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery( 
	  "SELECT L_EXTENDEDPRICE, COUNT(*) " +
          "FROM LINEITEM " +
          "WHERE L_EXTENDEDPRICE IN (2644.76,6118.28,29461.4) " +
          "GROUP BY L_EXTENDEDPRICE " +
          "ORDER BY L_EXTENDEDPRICE");
	while ( rset.next() ) 
          System.out.println( rset.getDouble(1) + " " + rset.getInt(2) );
  
     }
   catch (SQLException e )
   {
     String errmsg = e.getMessage();
     System.out.println( errmsg );
   }
  }
}


/* Testing
[oracle@localhost ~]$ javac task3.java
[oracle@localhost ~]$ time java task3
Connected to a database server

2644.76 7
6118.28 9
29461.4 4
Done.

real	1m58.825s
user	0m20.214s
sys	0m10.912s
[oracle@localhost ~]$ 



[oracle@localhost ~]$ javac solution3.java
[oracle@localhost ~]$ time java solution3
Connected to a database server

2644.76 7
6118.28 9
29461.4 4

real	0m3.204s
user	0m2.333s
sys	0m0.083s
[oracle@localhost ~]$ 

*/



