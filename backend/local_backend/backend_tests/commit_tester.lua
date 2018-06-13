CommitTester = class(CommitTester, BackendTester)

CommitTester._setup = function (self)
	self._tokens = 1
	self._token_type = "gold_tokens"
	self._name = "BackendTester Commits"
	self._timeout = math.huge
end

CommitTester._execute = function (self)
	self._tokens = self._tokens + 1

	ScriptBackendProfileAttribute.set(self._token_type, self._tokens)

	local commit_id, result = Backend.commit()
	self._commit_id = commit_id
	self._timeout = os.time() + 10
end

CommitTester.poll_answer = function (self)
	local result = nil

	if self._result then
		result = self._result
	elseif self._timeout < os.time() then
		result = "timeout"
	else
		result = Backend.query_commit(self._commit_id)
	end

	if result ~= Backend.COMMIT_WAITING then
		if result ~= Backend.COMMIT_SUCCESS then
			self:_report_error("Commit responded with:", result)
		end

		return true
	end
end

return
