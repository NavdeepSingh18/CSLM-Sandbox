table 50347 "Clerkship Activity Log Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Hospital","FM1/IM1 Preset","FM1/IM1 Application","FM1/IM1 Rotation","Core Rotation","Elective Rotation Offer","Elective Rotation Application","Elective Rotation","Non Affiliated",Documentation,"Clinical Hold","Rotation Cancellation Application";
        }
        field(3; "Activity"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Confirm,Approve,Schedule,Publish,Reject,Accept,Unblock,Block,Delete,Cancel,Apply,"Send for Approval",Interchange,"In-Review",Reopen,"Pending for Verification","Document Exception On","Document Exception Off","Document Status Complete","Document Status Incomplete","Titer Exception On","Titer Exception Off","Status Change","Date Change";
        }
        field(4; "Sub Activity"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not Applicable,Pending for Verification,Verified,Rejected,Requested-Required,Portal Submitted,Submitted,On File,Expired,Under Review,Auto Register - Basic Science New and Returning,Document Received NYC Office,Document Received On Campus,Forms Builder Submitted,No Longer Needed,Not Requested,Not Sent,Received but Rejected,Required,Requested - Not Required,Resubmitted,Revision to SchoolDocs,Revisions Required - Please Call Advisor,Sent,Under Review,When Needed';
            OptionMembers = "Not Applicable","Pending for Verification",Verified,Rejected,"Requested-Required","Portal Submitted","Submitted","On File","Expired","Under Review","AUTOREG","DRNYC","DROC","FBSUB","NA","NO","NOTSENT","REJ","REQ","REQNR","RESUBMIT","REVSD","RRPCA","SENT","UREVIEW","WN";
        }
        field(5; Remarks; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(21; "Source Name"; Text[120])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Document No."; Code[200])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(25; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(26; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(44; "User ID"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }
        field(45; "Activity Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(46; "Activity time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(47; "Activity Date time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure InsertLogEntry(LType: Integer;
    LActivity: Integer;
    LSourceNo: Code[20];
    LSourceName: Text[120];
    LDocumentNo: Code[200];
    LReasonCode: Code[20];
    LReasonDescription: Text[200];
    CourseCode: Code[20];
    CourseDescription: Text[100])
    var
        CALE: Record "Clerkship Activity Log Entries";
        EntryNo: Integer;
    begin
        CALE.Reset();
        if CALE.FindLast() then
            EntryNo := CALE."Entry No.";

        EntryNo += 1;
        CALE.Init();
        CALE."Entry No." := EntryNo;
        CALE.Type := LType;
        CALE.Activity := LActivity;
        CALE."Source No." := LSourceNo;
        CALE."Source Name" := LSourceName;
        CALE."Document No." := LDocumentNo;
        CALE."Reason Code" := LReasonCode;
        CALE."Reason Description" := LReasonDescription;
        CALE."Course Code" := CourseCode;
        CALE."Course Description" := CourseDescription;
        CALE."User ID" := UserId;
        CALE."Activity Date" := Today;
        CALE."Activity time" := Time;
        CALE."Activity Date time" := CurrentDateTime;
        CALE.Insert();
    end;

    procedure DocumentationInsertLogEntry(LType: Integer;
    LActivity: Integer;
    LSourceNo: Code[20];
    LSourceName: Text[120];
    LDocumentNo: Code[200];
    LReasonCode: Code[20];
    LReasonDescription: Text[200];
    CourseCode: Code[20];
    CourseDescription: Text[100];
    SubActivity: Option "Not Applicable","Pending for Verification",Verified,Rejected,"Requested-Required","Portal Submitted","Submitted","On File","Expired","Under Review","AUTOREG","DRNYC","DROC","FBSUB","NA","NO","NOTSENT","REJ","REQ","REQNR","RESUBMIT","REVSD","RRPCA","SENT","UREVIEW","WN")
    var
        CALE: Record "Clerkship Activity Log Entries";
        EntryNo: Integer;
    begin
        CALE.Reset();
        if CALE.FindLast() then
            EntryNo := CALE."Entry No.";

        EntryNo += 1;
        CALE.Init();
        CALE."Entry No." := EntryNo;
        CALE.Type := LType;
        CALE.Activity := LActivity;
        CALE."Source No." := LSourceNo;
        CALE."Source Name" := LSourceName;
        CALE."Document No." := LDocumentNo;
        CALE."Reason Code" := LReasonCode;
        CALE."Reason Description" := LReasonDescription;
        CALE."Course Code" := CourseCode;
        CALE."Course Description" := CourseDescription;
        CALE."User ID" := UserId;
        CALE."Activity Date" := Today;
        CALE."Activity time" := Time;
        CALE."Activity Date time" := CurrentDateTime;
        CALE."Sub Activity" := SubActivity;
        CALE.Insert();
    end;
}