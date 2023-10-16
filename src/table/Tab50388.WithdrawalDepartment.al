table 50388 "Withdrawal Department"
{
    Caption = 'Withdrawal Department';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Department Code", "Department Name";

    fields
    {
        field(1; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = CustomerContent;
            TableRelation = Department."Department Code";
            trigger OnValidate()
            begin
                if DepartmentRec.Get("Department Code") then
                    "Department Name" := DepartmentRec."Department Name"
                else
                    "Department Name" := '';
                // if "Document Type" <> "Document Type"::Withdrawal then
                //     "Type of Withdrawal" := "Type of Withdrawal"::Leave;
            end;

        }
        field(2; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(3; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Insert,Update';
            OptionMembers = Insert,Update;
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50006; "Type of Withdrawal"; Option)
        {
            OptionCaption = ' ,Course-Withdrawal,College-Withdrawal';
            OptionMembers = " ","Course-Withdrawal","College-Withdrawal",;
            Caption = 'Type of Withdrawal';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal" then
                    "Waiver Calculation Allowed" := false;
            end;
        }
        field(50007; "Final Approval"; Boolean)
        {
            Caption = 'Final Approval';
            DataClassification = CustomerContent;
            trigger onValidate()
            Var
                RecDepartmentCode: Record "Withdrawal Department";
            begin
                if "Final Approval" then begin
                    if "Document Type" = "Document Type"::Withdrawal then begin
                        RecDepartmentCode.reset();
                        RecDepartmentCode.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                        RecDepartmentCode.SetRange("Type of Withdrawal", "Type of Withdrawal");
                        RecDepartmentCode.SetRange("Final Approval", true);
                        IF RecDepartmentCode.findfirst() then
                            Repeat
                                //     IF (RecDepartmentCode."Type of Withdrawal" = "Type of Withdrawal"::" ") AND (RecDepartmentCode."Final Approval" = "Final Approval") then
                                Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2 & Type Of Withdrawal :%3 ', "Department Code", RecDepartmentCode."Department Code", RecDepartmentCode."Type of Withdrawal");
                            //     IF (RecDepartmentCode."Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal") AND (RecDepartmentCode."Final Approval" = "Final Approval") then
                            //         IF "Type of Withdrawal" = "Type of Withdrawal"::" " then
                            //             Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2 & Type Of Withdrawal :%3 ', "Department Code", RecDepartmentCode."Department Code", RecDepartmentCode."Type of Withdrawal");
                            //     IF (RecDepartmentCode."Type of Withdrawal" = "Type of Withdrawal"::"College-Withdrawal") AND (RecDepartmentCode."Final Approval" = "Final Approval") then
                            //         IF "Type of Withdrawal" = "Type of Withdrawal"::" " then
                            //             Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2 & Type Of Withdrawal :%3 ', "Department Code", RecDepartmentCode."Department Code", RecDepartmentCode."Type of Withdrawal");
                            Until RecDepartmentCode.Next() = 0;
                    end;
                    if "Document Type" <> "Document Type"::Withdrawal then begin
                        RecDepartmentCode.reset();
                        RecDepartmentCode.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                        RecDepartmentCode.SetRange("Document Type", "Document Type");
                        RecDepartmentCode.SetRange("Final Approval", true);
                        IF RecDepartmentCode.findfirst() then
                            Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2', "Department Code", RecDepartmentCode."Department Code");
                    end;
                end;
            end;

        }
        field(50008; "Waiver Calculation Allowed"; Boolean)
        {
            Caption = 'Waiver Calculation Allowed';
            DataClassification = CustomerContent;
            trigger onValidate()
            Var
                RecDepartmentCode: Record "Withdrawal Department";
            begin
                if "Waiver Calculation Allowed" then begin
                    // if "Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal" then
                    //     Error('You can not tick on waiver Calculation Allowed in case of Course Withdrawal.');

                    if "Document Type" = "Document Type"::Withdrawal then begin
                        RecDepartmentCode.reset();
                        RecDepartmentCode.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                        RecDepartmentCode.SetRange("Type of Withdrawal", "Type of Withdrawal");
                        RecDepartmentCode.SetRange("Waiver Calculation Allowed", true);
                        IF RecDepartmentCode.findfirst() then
                            Repeat
                                // IF (RecDepartmentCode."Type of Withdrawal" = "Type of Withdrawal"::" ") AND (RecDepartmentCode."Waiver Calculation Allowed" = "Waiver Calculation Allowed") then
                                Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2 & Type Of Withdrawal :%3 ', "Department Code", RecDepartmentCode."Department Code", RecDepartmentCode."Type of Withdrawal");
                            // IF (RecDepartmentCode."Type of Withdrawal" = "Type of Withdrawal"::"Course-Withdrawal") AND (RecDepartmentCode."Waiver Calculation Allowed" = "Waiver Calculation Allowed") then
                            //     IF "Type of Withdrawal" = "Type of Withdrawal"::" " then
                            //         Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2 & Type Of Withdrawal :%3 ', "Department Code", RecDepartmentCode."Department Code", RecDepartmentCode."Type of Withdrawal");
                            // IF (RecDepartmentCode."Type of Withdrawal" = "Type of Withdrawal"::"College-Withdrawal") AND (RecDepartmentCode."Waiver Calculation Allowed" = "Waiver Calculation Allowed") then
                            //     IF "Type of Withdrawal" = "Type of Withdrawal"::" " then
                            //         Error('You cannot tick final approval for Department: %1 ,Because it also tick for Department Code: %2 & Type Of Withdrawal :%3 ', "Department Code", RecDepartmentCode."Department Code", RecDepartmentCode."Type of Withdrawal");
                            Until RecDepartmentCode.Next() = 0;
                    end else
                        error('Document Type must be Withdrawal');
                end;
            end;

        }
        field(50009; "User Name"; Code[50])
        {
            Caption = 'User Group';
            DataClassification = CustomerContent;
            // TableRelation = "User Setup";//CSPL-00307-T1-T1516-CR
            TableRelation = "Workflow User Group";
            trigger OnValidate()
            begin
                //CSPL-00307-T1-T1516-CR
                // if UserSetupRec.Get("User Name") then begin
                //     "User E-Mail" := UserSetupRec."E-Mail";
                //     "User Phone No." := UserSetupRec."Phone No.";
                // end else begin
                //     "User E-Mail" := '';
                //     "User Phone No." := '';
                // end;
                //CSPL-00307-T1-T1516-CR
            end;

        }
        field(50010; "User E-Mail"; Text[100])
        {
            Caption = 'User E-Mail';
            DataClassification = CustomerContent;
            Editable = false;
            ExtendedDataType = Email;

        }
        field(50011; "User Phone No."; text[30])
        {
            Caption = 'User Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
            Editable = false;

        }
        field(50012; "Document Type"; option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Withdrawal BSIC,SLOA,ELOA,CLOA,Withdrawal CLN';//CSPL-00307-T1-T1516-CR
            OptionMembers = " ",Withdrawal,SLOA,ELOA,CLOA,"Withdrawal CLN";
            trigger OnValidate()
            begin
                "Final Approval" := false;
                "Waiver Calculation Allowed" := false;
            end;
        }
        field(50013; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';

        }
        field(50014; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';

        }
        field(50015; "CC E-Mail"; Text[100])
        {
            Caption = 'CC E-Mail';
            DataClassification = CustomerContent;
            ExtendedDataType = Email;

        }
        field(50016; "Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50017; "Update DOD"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Update LDA"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50019; "Update NSLDS"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50020; "Reject Permission"; Boolean)
        {
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(Key1; "Department Code", "Global Dimension 1 Code", "Document Type", "Type of Withdrawal")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    Begin
        Inserted := True;

    End;

    Trigger OnModify()
    Begin
        If xRec.Updated = Updated then
            Updated := true;

    End;

    Var
        DepartmentRec: Record Department;
        UserSetupRec: Record "User Setup";

    procedure GetDocumentType(StudentNo: Code[20]): Integer
    var
        RecStudent: Record "Student Master-CS";
        RecSemester: Record "Semester Master-CS";
    begin
        //CSPL-00307-T1-T1516-CR
        IF RecStudent.Get(StudentNo) then begin
            RecSemester.Reset();
            RecSemester.SetRange(Code, RecStudent.Semester);
            if RecSemester.FindFirst() then begin
                if RecSemester.Sequence IN [1, 2, 3, 4, 5] then
                    exit(Rec."Document Type"::Withdrawal)
                else
                    exit(Rec."Document Type"::"Withdrawal CLN");
            end;
        end;
    end;

    procedure GetUsersEmailid(DepartmentCode: Code[20]): Text
    var
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        UserSetup: Record "User Setup";
        RecDepartment: Record Department;
        EmailId: Text;
    begin
        //CSPL-00307-T1-T1516-CR

        RecDepartment.Reset();
        IF RecDepartment.Get(DepartmentCode) then
            exit(RecDepartment."Department Email");


        // WorkflowUserGroupMember.Reset();
        // WorkflowUserGroupMember.SetRange("Workflow User Group Code", WorkflowUserGroupCode);
        // if WorkflowUserGroupMember.FindSet() then
        //     repeat
        //         UserSetup.Reset();
        //         if UserSetup.Get(WorkflowUserGroupMember."User Name") then;
        //         if UserSetup."E-Mail" <> '' then begin
        //             if EmailId = '' then
        //                 EmailId := UserSetup."E-Mail"
        //             else
        //                 EmailId := EmailId + ';' + UserSetup."E-Mail";
        //         end;
        //     until WorkflowUserGroupMember.Next() = 0;


    end;

    procedure GetUserGroup(): Text
    var
        WorkflowUserGroupMember: Record "Workflow User Group Member";
        UserGroups: Text;
    begin
        //CSPL-00307-T1-T1516-CR
        UserSetupRec.Get(USERID);
        WorkflowUserGroupMember.Reset();
        WorkflowUserGroupMember.SetCurrentKey("Workflow User Group Code");
        WorkflowUserGroupMember.SetFilter("User Name", '%1', UserSetupRec."User ID");
        IF WorkflowUserGroupMember.FindSet() then
            repeat
                IF UserGroups = '' then
                    UserGroups := WorkflowUserGroupMember."Workflow User Group Code"
                else
                    UserGroups := UserGroups + '|' + WorkflowUserGroupMember."Workflow User Group Code";
            until WorkflowUserGroupMember.Next() = 0;

        exit(UserGroups);
    end;

}
