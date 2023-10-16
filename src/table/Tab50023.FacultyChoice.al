table 50023 "Faculty Choice"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                                 Remarks
    // 1         CSPL-00092    08-05-2019    Faculty Code - OnValidate               Find Line No
    // 2         CSPL-00092    08-05-2019    Choice - OnValidate                     Assign Value in Subject Classification Field

    LookupPageID = 50164;

    fields
    {
        field(1; "Faculty Code"; Code[20])
        {
            //TableRelation = Employee;
            Caption = 'Site Visit Document No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Find Line No::CSPL-00092::08-05-2019: Start
                recFacultyCh.Reset();
                recFacultyCh.SETRANGE(recFacultyCh."Faculty Code", "Faculty Code");
                IF recFacultyCh.FIND('+') THEN
                    "Line No" := recFacultyCh."Line No" + 10000
                ELSE
                    "Line No" := 10000;
                //Code added for Find Line No::CSPL-00092::08-05-2019: End
            end;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Choice; Code[20])
        {
            TableRelation = "Certificate-CS";
            Caption = 'Choice';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Subject Classification Field::CSPL-00092::08-05-2019: Start
                RecSubC.Reset();
                RecSubC.SETRANGE(RecSubC.Code, recFacultyCh.Choice);
                IF RecSubC.FindFirst() THEN
                    "Subject Classification" := RecSubC."Subject Classification";
                //Code added for Assign Value in Subject Classification Field::CSPL-00092::08-05-2019: End
            end;
        }
        field(4; "Subject Classification"; Code[20])
        {
            TableRelation = "Fee Classification Master-CS";
            Caption = 'Subject Classification';
            DataClassification = CustomerContent;
        }
        Field(5; "Site Visit Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(6; "Document Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }

        Field(7; "Document Sub Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(8; Description; Text[2048])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(9; "Document Description"; Text[2048])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        field(10; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        field(11; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(12; "Transaction No."; Code[30])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(13; "File Name"; Text[300])
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        field(14; "Uploaded Source"; Option)
        {
            OptionCaption = ' ,SalesForce,SLcMBC,SLcMPortal,SchoolDocs';
            OptionMembers = " ",SalesForce,SLcMBC,SLcMPortal,SchoolDocs;
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        field(15; "Document Status"; Option)
        {
            OptionCaption = ' ,Pending for Verification,Verified,Rejected,Requested-Required,Portal Submitted,Submitted,On File,Expired,Under Review,Auto Register - Basic Science New and Returning,Document Received NYC Office,Document Received On Campus,Forms Builder Submitted,No Longer Needed,Not Requested,Not Sent,Received but Rejected,Required,Requested - Not Required,Resubmitted,Revision to SchoolDocs,Revisions Required - Please Call Advisor,Sent,Under Review,When Needed';
            OptionMembers = " ","Pending for Verification",Verified,Rejected,"Requested-Required","Portal Submitted","Submitted","On File","Expired","Under Review","AUTOREG","DRNYC","DROC","FBSUB","NA","NO","NOTSENT","REJ","REQ","REQNR","RESUBMIT","REVSD","RRPCA","SENT","UREVIEW","WN";
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        field(16; "Uploaded By"; code[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'For Site Visit';

        }
        field(17; "Uploaded On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'For Site Visit';

        }
        field(18; "Document Update Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        field(19; "Submission Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(20; "SDA Synced"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }
        Field(21; "SDA Entry No"; Integer)
        {
            DataClassification = CustomerContent;
            Description = 'For Site Visit';
        }

    }

    keys
    {
        key(Key1; "Line No", "Faculty Code")
        {
        }
        key(Key2; "Faculty Code", "Line No", Choice)
        {
        }
    }

    fieldgroups
    {
    }

    var
        recFacultyCh: Record "Faculty Choice";
        RecSubC: Record "Subject Master-CS";
}

