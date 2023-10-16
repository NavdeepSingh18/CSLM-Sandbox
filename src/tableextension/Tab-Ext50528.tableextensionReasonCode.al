tableextension 50528 "tableextension50528" extends "Reason Code"
{
    // version NAVW19.00.00.45778-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00136    02-05-2019    OnModify                      Code added for Assign Value in Updated Field
    fields
    {
        field(50000; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02-05-2019';
        }
        field(50001; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Issue,Financial AID,Withdrawal,Leave,Housing,Hospital Block,Inventory Block,Clerkship Documentation,Special Accommodation Rejection,FM1/IM1 Application Rejection,Elective Offer Application Rejection,Elective Offer Alternates Rejection,Non Affiliated Application Rejection,Rotation Cancellation,Clinical Hold,Visit,EED,Attendence,GradeBook,TimeTable,R2T4,User Task,External Exam,Internal Exam';
            OptionMembers = " ","Issue","Financial AID",Withdrawal,Leave,Housing,"Hospital Block","Inventory Block","Clerkship Documentation","Special Accommodation Rejection","FM1/IM1 Application Rejection","Elective Offer Application Rejection","Elective Offer Alternates Rejection","Non Affiliated Application Rejection","Rotation Cancellation","Clinical Hold",Visit,EED,Attendence,GradeBook,TimeTable,R2T4,"User Task","External Exam","Internal Exam";
        }
        field(50002; Block; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2021';
        }
        field(50003; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        Field(50004; "Show Description"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    //Unsupported feature: Code Insertion on "OnModify".

    trigger OnModify()
    begin

        //Code added for Assign Value in Updated Field::CSPL-00136::02-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Assign Value in Updated Field::CSPL-00136::02-05-2019: Start

    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;
}

