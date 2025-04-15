# 현재 디렉토리 및 하위 폴더에서 .git 폴더 검색 및 삭제
Get-ChildItem -Path . -Recurse -Force -Directory -Filter ".git" | ForEach-Object {
    $gitFolder = $_.FullName
    Write-Host "`n[!] 발견된 .git 폴더: $gitFolder" -ForegroundColor Yellow

    # 사용자에게 삭제 여부 확인
    $response = Read-Host "이 폴더를 삭제하시겠습니까? (Y/N)"
    
    if ($response -match '^[Yy]$') {
        try {
            Remove-Item -LiteralPath $gitFolder -Recurse -Force
            Write-Host "✅ 삭제 완료: $gitFolder" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ 삭제 실패: $gitFolder" -ForegroundColor Red
            Write-Host $_.Exception.Message
        }
    }
    else {
        Write-Host "⚠️ 삭제 취소됨: $gitFolder" -ForegroundColor Cyan
    }
}
