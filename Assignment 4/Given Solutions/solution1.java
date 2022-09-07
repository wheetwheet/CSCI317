import java.sql.*;
class solution1
{
  public static void main (String args [])
       throws SQLException, ClassNotFoundException
  {
    Class.forName ("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection
       ("jdbc:oracle:thin:@localhost:1521:db",  "tpchr", "oracle");
  try{
	System.out.println( "Just started");
	Statement stmt = conn.createStatement();
        ResultSet rset = stmt.executeQuery( "SELECT AVG(L_EXTENDEDPRICE) FROM LINEITEM" );
        double l_exp = 0.0;
	while ( rset.next() ) 
           l_exp = rset.getFloat(1);

	System.out.println( l_exp );
    }
   catch (SQLException e )
   {
     String errmsg = e.getMessage();
     System.out.println( errmsg );
   }
  }
}
