codeunit 50021 BulkTranscript
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   18/02/2019     CreateProgStage2Formula()-Function       Code added for create program formula.
    // 02    CSPL-00059   18/02/2019     CreateProgStage1Formula()-Function       Code added for create program formula .


    trigger OnRun()
    begin
        PrintBulkTranscript();
        RePrintBulkTranscript();
    end;

    procedure CreateProgStage2Formula(Prog: Code[20]; ProgLineNo: Integer; ProgListN: Integer; Clrpara: Char)
    var
        CourseFormulaDetailsCS: Record "Course Formula Details-CS";
        CourseRankingSummaryCS: Record "Course Ranking Summary-CS";
        TextFormula: Code[250];
        LocalBool: Boolean;
        "LocalOrderNo.": Integer;
        IntMaxFormula: Integer;

    begin
        //Code added for create program formula::CSPL-00059::18022019: Start
        LocalBool := FALSE;
        TextFormula := '';
        IntMaxFormula := 1;
        CourseRankingSummaryCS.SETCURRENTKEY("Course Code", "Course Line No.", "List No.", "Order Number");
        CourseRankingSummaryCS.SETRANGE("Course Code", Prog);
        CourseRankingSummaryCS.SETRANGE("Course Line No.", ProgLineNo);
        CourseRankingSummaryCS.SETRANGE("List No.", ProgListN);
        IF CourseRankingSummaryCS.FINDSET() THEN
            REPEAT
                IF (CourseRankingSummaryCS."Order Number" <> "LocalOrderNo.") AND LocalBool THEN BEGIN
                    TextFormula := FORMAT(TextFormula + ',');
                    IntMaxFormula += 1;
                END ELSE
                    IF CourseRankingSummaryCS."Order Number" = "LocalOrderNo." THEN
                        TextFormula := FORMAT(TextFormula + '+');
                TextFormula := FORmat(TextFormula + '(' + CourseRankingSummaryCS.Code + FORMAT(ProgListN) + FORMAT(CourseRankingSummaryCS.Percentage)
                  + ')');
                "LocalOrderNo." := CourseRankingSummaryCS."Order Number";
                LocalBool := TRUE;
            UNTIL CourseRankingSummaryCS.NEXT() = 0;

        IF CourseFormulaDetailsCS.GET(Prog, ProgLineNo) THEN BEGIN
            CourseFormulaDetailsCS."Stage2 Formula" := TextFormula;
            CourseFormulaDetailsCS."No of Ranking Formula" := IntMaxFormula;
            CourseFormulaDetailsCS.Modify();
        END;
        //Code added for create program formula::CSPL-00059::18022019: End
    end;

    procedure CreateProgStage1Formula(Prog: Code[20]; ProgLineNo: Integer; ProgListN: Integer; Clrpara: Char)
    var
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
        CourseFormulaDetailsCS: Record "Course Formula Details-CS";
        TextFormula: Code[250];
        LocalBool: Boolean;
        "LocalOrderNo.": Integer;
        IntMaxFormula: Integer;
    begin
        //Code added for create program formula::CSPL-00059::18022019: Start
        LocalBool := FALSE;
        TextFormula := '';
        IntMaxFormula := 1;
        CourseEligibleSummaryCS.Reset();
        CourseEligibleSummaryCS.SETCURRENTKEY("Course Code", "Course Line No.", "List No.", "Order Number");
        CourseEligibleSummaryCS.SETRANGE("Course Code", Prog);
        CourseEligibleSummaryCS.SETRANGE("Course Line No.", ProgLineNo);
        CourseEligibleSummaryCS.SETRANGE("List No.", ProgListN);
        IF CourseEligibleSummaryCS.FINDSET() THEN
            REPEAT
                IF (CourseEligibleSummaryCS."Order Number" <> "LocalOrderNo.") AND LocalBool THEN BEGIN
                    TextFormula := FORMAT(TextFormula + ',');
                    IntMaxFormula += 1;
                END ELSE
                    IF CourseEligibleSummaryCS."Order Number" = "LocalOrderNo." THEN
                        TextFormula := FORMAT(TextFormula + '+');
                TextFormula := FORMAT(TextFormula + '(' + CourseEligibleSummaryCS.Code + FORMAT(Clrpara) + FORMAT(CourseEligibleSummaryCS.Percentage) +
                  ')');

                "LocalOrderNo." := CourseEligibleSummaryCS."Order Number";
                LocalBool := TRUE;
            UNTIL CourseEligibleSummaryCS.NEXT() = 0;

        IF CourseFormulaDetailsCS.GET(Prog, ProgLineNo) THEN BEGIN
            CourseFormulaDetailsCS."Stage1 Formula" := TextFormula;
            CourseFormulaDetailsCS."No of Elgible Formula" := IntMaxFormula;
            CourseFormulaDetailsCS.Modify();
        END;
        //Code added for create program formula::CSPL-00059::18022019: End
    end;

    procedure PrintBulkTranscript()
    Var
        TranscriptLine: Record "Competition L-CS";
        TranscriptHdr: Record "Competition H-CS";
        StudentMAster: Record "Student Master-CS";
        StudentStatusMgmt: Codeunit "Student Status Mangement";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        totalcount: Integer;
        Counter: Integer;

    Begin
        If GuiAllowed then
            WindowDialog.Open('Fetching Data....\' + Text001Lbl);
        TranscriptLine.Reset();
        TranscriptLine.SetCurrentKey("Document No.");
        TranscriptLine.SetRange(Print, false);
        IF TranscriptLine.FindSet() then begin
            totalcount := TranscriptLine.Count();
            repeat
                TranscriptHdr.Reset();
                TranscriptHdr.SetRange("No.", TranscriptLine."Document No.");
                TranscriptHdr.FindFirst();

                StudentMAster.Reset();
                StudentMAster.SetRange("No.", TranscriptLine."SLcM No");
                IF StudentMAster.FindFirst() then begin
                    counter += 1;
                    if GuiAllowed then
                        WindowDialog.Update(1, StudentMAster."No." + ' - ' + format(counter) + ' of ' + format(totalcount));
                    If TranscriptHdr."Print Type" = TranscriptHdr."Print Type"::"Official Transcript" then
                        StudentStatusMgmt.OfficialTranscriptsBulkExport(StudentMAster, TranscriptHdr."Last Print Date", TranscriptLine."Document No.", TranscriptLine."Student Division");
                    If TranscriptHdr."Print Type" = TranscriptHdr."Print Type"::"UnOfficial Transcript" then
                        StudentStatusMgmt.UnOfficialTranscriptsBulkExport(StudentMAster, TranscriptHdr."Last Print Date", TranscriptLine."Document No.", TranscriptLine."Student Division");
                end;

            until TranscriptLine.Next() = 0;
        end;
        If GuiAllowed then
            WindowDialog.Close();
    End;

    procedure RePrintBulkTranscript()
    Var
        TranscriptLine: Record "Competition L-CS";
        TranscriptHdr: Record "Competition H-CS";
        StudentMAster: Record "Student Master-CS";
        StudentStatusMgmt: Codeunit "Student Status Mangement";
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        totalcount: Integer;
        Counter: Integer;

    Begin
        If GuiAllowed then
            WindowDialog.Open('Fetching Data....\' + Text001Lbl);
        TranscriptLine.Reset();
        TranscriptLine.SetCurrentKey("Document No.");
        TranscriptLine.SetRange(Reprint, false);
        IF TranscriptLine.FindSet() then begin
            totalcount := TranscriptLine.Count();
            repeat
                TranscriptHdr.Reset();
                TranscriptHdr.SetRange("No.", TranscriptLine."Document No.");
                TranscriptHdr.FindFirst();

                StudentMAster.Reset();
                StudentMAster.SetRange("No.", TranscriptLine."SLcM No");
                IF StudentMAster.FindFirst() then begin
                    counter += 1;
                    if GuiAllowed then
                        WindowDialog.Update(1, StudentMAster."No." + ' - ' + format(counter) + ' of ' + format(totalcount));
                    If TranscriptHdr."Print Type" = TranscriptHdr."Print Type"::"Official Transcript" then
                        StudentStatusMgmt.OfficialTranscriptsBulkExport(StudentMAster, TranscriptHdr."Last Print Date", TranscriptLine."Document No.", TranscriptLine."Student Division");
                    If TranscriptHdr."Print Type" = TranscriptHdr."Print Type"::"UnOfficial Transcript" then
                        StudentStatusMgmt.UnOfficialTranscriptsBulkExport(StudentMAster, TranscriptHdr."Last Print Date", TranscriptLine."Document No.", TranscriptLine."Student Division");
                end;


            until TranscriptLine.Next() = 0;

        end;
        IF GuiAllowed then
            WindowDialog.Close();

    End;
}

