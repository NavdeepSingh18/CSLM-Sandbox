table 60000 "CDS cr33f_StudentMaster"
{
  ExternalName = 'cr33f_studentmaster';
  TableType = CDS;
  Description = '';

  fields
  {
    field(1; cr33f_StudentMasterId; GUID)
    {
      ExternalName = 'cr33f_studentmasterid';
      ExternalType = 'Uniqueidentifier';
      ExternalAccess = Insert;
      Description = 'Unique identifier for entity instances';
      Caption = 'Student Master';
    }
    field(2; CreatedOn; Datetime)
    {
      ExternalName = 'createdon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Date and time when the record was created.';
      Caption = 'Created On';
    }
    field(4; ModifiedOn; Datetime)
    {
      ExternalName = 'modifiedon';
      ExternalType = 'DateTime';
      ExternalAccess = Read;
      Description = 'Date and time when the record was modified.';
      Caption = 'Modified On';
    }
    field(25; statecode; Option)
    {
      ExternalName = 'statecode';
      ExternalType = 'State';
      ExternalAccess = Modify;
      Description = 'Status of the Student Master';
      Caption = 'Status';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 0, 1;
    }
    field(27; statuscode; Option)
    {
      ExternalName = 'statuscode';
      ExternalType = 'Status';
      Description = 'Reason for the status of the Student Master';
      Caption = 'Status Reason';
      InitValue = " ";
      OptionMembers = " ", Active, Inactive;
      OptionOrdinalValues = -1, 1, 2;
    }
    field(29; VersionNumber; BigInteger)
    {
      ExternalName = 'versionnumber';
      ExternalType = 'BigInt';
      ExternalAccess = Read;
      Description = 'Version Number';
      Caption = 'Version Number';
    }
    field(30; ImportSequenceNumber; Integer)
    {
      ExternalName = 'importsequencenumber';
      ExternalType = 'Integer';
      ExternalAccess = Insert;
      Description = 'Sequence number of the import that created this record.';
      Caption = 'Import Sequence Number';
    }
    field(31; OverriddenCreatedOn; Date)
    {
      ExternalName = 'overriddencreatedon';
      ExternalType = 'DateTime';
      ExternalAccess = Insert;
      Description = 'Date and time that the record was migrated.';
      Caption = 'Record Created On';
    }
    field(32; TimeZoneRuleVersionNumber; Integer)
    {
      ExternalName = 'timezoneruleversionnumber';
      ExternalType = 'Integer';
      Description = 'For internal use only.';
      Caption = 'Time Zone Rule Version Number';
    }
    field(33; UTCConversionTimeZoneCode; Integer)
    {
      ExternalName = 'utcconversiontimezonecode';
      ExternalType = 'Integer';
      Description = 'Time zone code that was in use when the record was created.';
      Caption = 'UTC Conversion Time Zone Code';
    }
    field(34; cr33f_Newcolumn; Text[100])
    {
      ExternalName = 'cr33f_newcolumn';
      ExternalType = 'String';
      Description = '';
      Caption = 'New column';
    }
    field(35; cr33f_StudentNo; Text[100])
    {
      ExternalName = 'cr33f_studentno';
      ExternalType = 'String';
      Description = '';
      Caption = 'Student No';
    }
    field(36; cr33f_StudentName; Text[100])
    {
      ExternalName = 'cr33f_studentname';
      ExternalType = 'String';
      Description = '';
      Caption = 'Student Name';
    }
    field(37; cr33f_Address; Text[100])
    {
      ExternalName = 'cr33f_address';
      ExternalType = 'String';
      Description = '';
      Caption = 'Address';
    }
    field(38; cr33f_ContactNo; Text[100])
    {
      ExternalName = 'cr33f_contactno';
      ExternalType = 'String';
      Description = '';
      Caption = 'Contact No';
    }
  }
  keys
  {
    key(PK; cr33f_StudentMasterId)
    {
      Clustered = true;
    }
    key(Name; cr33f_Newcolumn)
    {
    }
  }
  fieldgroups
  {
    fieldgroup(DropDown; cr33f_Newcolumn)
    {
    }
  }
}