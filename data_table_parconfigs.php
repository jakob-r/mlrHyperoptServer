<?php
include("conf.php");
/**
 * Script:    DataTables server-side script for PHP 5.2+ and MySQL 4.1+
 * Notes:     Based on a script by Allan Jardine that used the old PHP mysql_* functions.
 *            Rewritten to use the newer object oriented mysqli extension.
 * Copyright: 2010 - Allan Jardine (original script)
 *            2012 - Kari Söderholm, aka Haprog (updates)
 * License:   GPL v2 or BSD (3-point)
 */
mb_internal_encoding('UTF-8');
 
/**
 * Array of database columns which should be read and sent back to DataTables. Use a space where
 * you want to insert a non-database field (for example a counter or static image)
 */
$aColumns = array( 'id', 'learner_class', 'download_count' );
  
// Indexed column (used for fast and accurate table cardinality)
$sIndexColumn = 'id';
  
// DB table to use
$sTable = DB_PREFIX.'parconfigs';
  
// Database connection information
$gaSql['user']     = DB_USER;
$gaSql['password'] = DB_PASS;
$gaSql['db']       = DB_NAME;
$gaSql['server']   = DB_HOST;
$gaSql['port']     = 3306; // 3306 is the default MySQL port
 
// Input method (use $_GET, $_POST or $_REQUEST)
$input =& $_GET;
 
/** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * If you just want to use the basic configuration for DataTables with PHP server-side, there is
 * no need to edit below this line
 */
 
/**
 * Character set to use for the MySQL connection.
 * MySQL will return all strings in this charset to PHP (if the data is stored correctly in the database).
 */
$gaSql['charset']  = 'utf8';
 
/**
 * MySQL connection
 */
$db = new mysqli($gaSql['server'], $gaSql['user'], $gaSql['password'], $gaSql['db'], $gaSql['port']);
if (mysqli_connect_error()) {
    die( 'Error connecting to MySQL server (' . mysqli_connect_errno() .') '. mysqli_connect_error() );
}
 
if (!$db->set_charset($gaSql['charset'])) {
    die( 'Error loading character set "'.$gaSql['charset'].'": '.$db->error );
}
  
  
/**
 * Paging
 */
$sLimit = "";
if ( isset( $input['iDisplayStart'] ) && $input['iDisplayLength'] != '-1' ) {
    $sLimit = " LIMIT ".intval( $input['iDisplayStart'] ).", ".intval( $input['iDisplayLength'] );
}
  
  
/**
 * Ordering
 */
$aOrderingRules = array();
if ( isset( $input['iSortCol_0'] ) ) {
    $iSortingCols = intval( $input['iSortingCols'] );
    for ( $i=0 ; $i<$iSortingCols ; $i++ ) {
        if ( $input[ 'bSortable_'.intval($input['iSortCol_'.$i]) ] == 'true' ) {
            $aOrderingRules[] =
                "`".$aColumns[ intval( $input['iSortCol_'.$i] ) ]."` "
                .($input['sSortDir_'.$i]==='asc' ? 'asc' : 'desc');
        }
    }
}
 
if (!empty($aOrderingRules)) {
    $sOrder = " ORDER BY ".implode(", ", $aOrderingRules);
} else {
    $sOrder = "";
}
  
 
/**
 * Filtering
 * NOTE this does not match the built-in DataTables filtering which does it
 * word by word on any field. It's possible to do here, but concerned about efficiency
 * on very large tables, and MySQL's regex functionality is very limited
 */
$iColumnCount = count($aColumns);
 
if ( isset($input['sSearch']) && $input['sSearch'] != "" ) {
    $aFilteringRules = array();
    for ( $i=0 ; $i<$iColumnCount ; $i++ ) {
        if ( isset($input['bSearchable_'.$i]) && $input['bSearchable_'.$i] == 'true' ) {
            $aFilteringRules[] = "`".$aColumns[$i]."` LIKE '%".$db->real_escape_string( $input['sSearch'] )."%'";
        }
    }
    if (!empty($aFilteringRules)) {
        $aFilteringRules = array('('.implode(" OR ", $aFilteringRules).')');
    }
}
  
// Individual column filtering
for ( $i=0 ; $i<$iColumnCount ; $i++ ) {
    if ( isset($input['bSearchable_'.$i]) && $input['bSearchable_'.$i] == 'true' && $input['sSearch_'.$i] != '' ) {
        $aFilteringRules[] = "`".$aColumns[$i]."` LIKE '%".$db->real_escape_string($input['sSearch_'.$i])."%'";
    }
}
 
if (!empty($aFilteringRules)) {
    $sWhere = " WHERE ".implode(" AND ", $aFilteringRules);
} else {
    $sWhere = "";
}
  
  
/**
 * SQL queries
 * Get data to display
 */
$aQueryColumns = array();
foreach ($aColumns as $col) {
    if ($col != ' ') {
        $aQueryColumns[] = $col;
    }
}
 
$sQuery = "
    SELECT SQL_CALC_FOUND_ROWS `".implode("`, `", $aQueryColumns)."`
    FROM `".$sTable."`".$sWhere.$sOrder.$sLimit;
 
$rResult = $db->query( $sQuery ) or die($db->error);
  
// Data set length after filtering
$sQuery = "SELECT FOUND_ROWS()";
$rResultFilterTotal = $db->query( $sQuery ) or die($db->error);
list($iFilteredTotal) = $rResultFilterTotal->fetch_row();
 
// Total data set length
$sQuery = "SELECT COUNT(`".$sIndexColumn."`) FROM `".$sTable."`";
$rResultTotal = $db->query( $sQuery ) or die($db->error);
list($iTotal) = $rResultTotal->fetch_row();
  
  
/**
 * Output
 */
$output = array(
    "sEcho"                => intval($input['sEcho']),
    "iTotalRecords"        => $iTotal,
    "iTotalDisplayRecords" => $iFilteredTotal,
    "aaData"               => array(),
);
  
while ( $aRow = $rResult->fetch_assoc() ) {
    $row = array();
    for ( $i=0 ; $i<$iColumnCount ; $i++ ) {
        if ( $aColumns[$i] == 'version' ) {
            // Special output formatting for 'version' column
            $row[] = ($aRow[ $aColumns[$i] ]=='0') ? '-' : $aRow[ $aColumns[$i] ];
        } elseif ( $aColumns[$i] != ' ' ) {
            // General output
            $row[] = $aRow[ $aColumns[$i] ];
        }
    }
    $output['aaData'][] = $row;
}

header('Content-Type: application/json');
echo json_encode( $output );
?>