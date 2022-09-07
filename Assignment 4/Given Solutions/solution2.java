import java.sql.*;
class solution2
{
  public static void main (String args [])
       throws SQLException, ClassNotFoundException
  {
    // Load the Oracle JDBC driver
    Class.forName ("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection
       ("jdbc:oracle:thin:@localhost:1521:db",  "tpchr", "oracle");
  try{
	System.out.println( "Just started");
	Statement stmt1 = conn.createStatement();
    	Statement stmt2 = conn.createStatement();
    	Statement stmt3 = conn.createStatement();
        ResultSet rset1 = stmt1.executeQuery( "SELECT P_PARTKEY, COUNT(*) FROM LINEITEM JOIN PART ON L_PARTKEY = P_PARTKEY WHERE P_BRAND = 'Brand#35' AND P_SIZE > 49 GROUP BY P_PARTKEY ORDER BY P_PARTKEY" );
	long counter;
	long p_partkey1 = 0;
	while ( rset1.next() ) 
        {
  		p_partkey1 = rset1.getInt(1);
		counter = rset1.getInt(2);
		System.out.println( p_partkey1 + "   " + counter);
	}
    }
   catch (SQLException e )
   {
     String errmsg = e.getMessage();
     System.out.println( errmsg );
   }
  }
}
