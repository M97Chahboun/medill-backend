//This column stores all data using storage classes NULL, TEXT or BLOB.

class TEXT{}
 	
///This column may contain values using all five storage classes.
class NUMERIC{}

/// the same as a column with NUMERIC affinity, with an exception in a CAST expression.

class INTEGER{}

	
///like a column with NUMERIC affinity except that it forces integer values into floating point representation.

class REAL{}

/// 	A column with affinity NONE does not prefer one storage class over another and no attempt is made to coerce data from one storage class into another.

class NONE{}

