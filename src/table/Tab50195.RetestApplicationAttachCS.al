table 50195 "Retest Application Attach-CS"
{
    // version V.001-CS


    fields
    {
        field(1;"Student No";Code[20])
        {
        }
        field(2;"Application No";Code[20])
        {
        }
        field(3;"Line No";Integer)
        {
        }
        field(4;"Academic Year";Code[10])
        {
        }
        field(5;"Course Code";Code[20])
        {
        }
        field(6;"Student Name";Text[100])
        {
        }
        field(7;Semester;Code[10])
        {
        }
        field(8;"Subject Code";Code[10])
        {
        }
        field(9;"Document Path";Text[100])
        {
        }
        field(10;"Document Name";Text[30])
        {
        }
        field(11;"Global Dimension 1 Code";Code[20])
        {
        }
        field(12;"Global Dimension 2 Code";Code[20])
        {
        }
        field(13;"Created By";Text[30])
        {
        }
        field(14;"Created Date";Date)
        {
        }
        field(15;"Updated By";Text[30])
        {
        }
        field(16;"Updated Date";Date)
        {
        }
        field(17;"Document Description";Text[50])
        {
        }
        field(18;"Subject Type";Code[20])
        {
        }
        field(19;"Type Of Course";Option)
        {
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(20;Status;Option)
        {
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(21;Remark;Text[150])
        {
        }
        field(22;"Approved By";Text[50])
        {
        }
        field(23;"Approved Date";Date)
        {
        }
        field(24;"Exam Type";Option)
        {
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(25;"Old Marks";Decimal)
        {
        }
        field(26;"New Marks";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Student No")
        {
        }
    }

    fieldgroups
    {
    }
}

