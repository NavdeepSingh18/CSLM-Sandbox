tableextension 50559 "tableextension50559" extends "User Setup"
{
    // version NAVW19.00.00.45778-CS

    fields
    {
        field(50000; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 03-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50002; "Withdrawal Approval"; Boolean)
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Withdrawal Approval';
            DataClassification = CustomerContent;
        }
        field(50003; "Student Edit"; Boolean)
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Student Edit';
            DataClassification = CustomerContent;
        }
        field(50004; "Batch Permission"; Boolean)
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Batch Permission';
            DataClassification = CustomerContent;
        }
        field(50005; "Student Subject Permission"; Boolean)
        {
            Description = 'CS Field Added 03-05-2019';
            Caption = 'Student Subject Permission';
            DataClassification = CustomerContent;
        }
        field(50006; "ELOA Approver"; Text[2048])
        {
            Caption = 'ELOA Approver';
            DataClassification = ToBeClassified;
        }
        field(50007; "1st level Approve"; Boolean)
        {
            Caption = '1st level Approve';
            DataClassification = ToBeClassified;
        }
        field(50008; "2nd Level Approve"; Boolean)
        {
            Caption = '2nd Level Approve';
            DataClassification = ToBeClassified;
        }
        field(50009; "3rd level Approve"; Boolean)
        {
            Caption = '3rd level Approve';
            DataClassification = ToBeClassified;
        }
        field(50010; "Department Approver"; Option)
        {
            Caption = 'Department Approver';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Bursar,Financial Aid,Residential Services,Student Services,Registrar,Admissions,Clinicals,EED Pre-Clinical,EED Clinical,Graduate Affairs,Examination,Graduation,BackOffice';
            OptionMembers = " ","Bursar Department","Financial Aid Department","Residential Services","Immigration Department","Registrar Department","Admissions","Clinical Details","EED Pre-Clinical","EED Clinical","Graduate Affairs","Examination","Graduation",BackOffice;
        }
        field(50011; "Clinical Administrator"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Administrator';
        }
        field(50012; "Bursar Clinical Administrator"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bursar Clinical Administrator';
        }
        field(50013; "Education Setup Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Education Setup Allowed';
        }
        field(50014; "Fee Setup Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Setup Allowed';
        }
        field(50015; "Academic Setup Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Setup Allowed';
        }
        field(50016; "Change Status Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Change Status Allowed';
        }
        field(50017; "Status Change Log Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Status Change Log Allowed';
        }
        field(50018; "User Setup Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'User Setup Allowed';
        }
        field(50019; "Grade Upload Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50020; "Grade Modify Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50021; "API URLs Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50022; "Document Delete Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50023; "Transcript Print Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50024; "Transcript Hold Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50025; "Published Score Delete Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50026; "GPA Calculation Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50027; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50028; "Leaves Of Absence"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "OLR Retuning Student Data Update"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50031; "Course Change Permission"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50032; "Ferpa Insert Allowed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50033; "Allow Create PO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50034; Signature; Blob)
        {
            Caption = 'Signature';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        Field(50035; "Housing Vacate Permission"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50036; "NMI Authorization Permission"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        Field(50037; "Export Batch Transcript"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50038; "NMI Permission"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50039; "SSE Delete Permission"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Subject Exam Delete Permission';
        }
        field(50040; "Rotation Deletion Allowed"; Boolean)
        {
            Caption = 'Rotation Deletion Allowed';
            DataClassification = CustomerContent;
        }
        field(50041; "Assign F Grade Allowed"; Boolean)
        {
            Caption = 'Assign F Grade Allowed';
            DataClassification = CustomerContent;
        }
        field(50042; "Insert Student Subject Exam"; Boolean)
        {
            Caption = 'Insert Student Subject Exam';
            DataClassification = CustomerContent;
        }
        field(50043; "Modify Student Subject Exam"; Boolean)
        {
            Caption = 'Modify Student Subject Exam';
            DataClassification = CustomerContent;
        }

        field(50044; "EED Chair"; Boolean)
        {
            Caption = 'EED Chair';
            DataClassification = CustomerContent;
        }
        Field(50045; "Current Session"; Boolean)          //12Aug2022
        {
            DataClassification = CustomerContent;
        }
        Field(50046; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
            DataClassification = CustomerContent;
        }
        field(50047; "Housing Cost Permission"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Cost Change Permission';
        }
        field(50048; "View Attendance Tracking"; Boolean)
        {
            //CSPL-00307 T1-T1518
            DataClassification = ToBeClassified;
        }
        field(50049; "Edit Attendance Tracking"; Boolean)
        {   //CSPL-00307 T1-T1518
            DataClassification = ToBeClassified;
        }
        Field(50050; "No. Series Permission"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50051; "User Task Permission"; Boolean)
        {
            Caption = 'User Task Creation Permission';
            DataClassification = CustomerContent;
        }
        


        field(50500; "SSN Permission"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Not In Use';

        }
        field(50501; "SSN Permissions"; Boolean)
        {
            DataClassification = CustomerContent;

        }



    }

}