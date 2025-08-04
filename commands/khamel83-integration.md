---
description: Khamel83 Cost Optimization Integration for Agent OS
globs:
alwaysApply: false
version: 1.0
encoding: UTF-8
---

# Khamel83 Cost Optimization Integration

<ai_meta>
  <rules>Integrate cost optimization workflows with base Agent OS commands</rules>
  <format>UTF-8, LF, 2-space indent, no header indent</format>
</ai_meta>

## Overview

This integration layer enables Agent OS to automatically use Khamel83 cost optimization templates and workflows.

<integration_detection>
  <check_once>
    AT START OF ANY AGENT OS WORKFLOW:
    SET has_khamel83 = (directory templates/.khamel83 exists)
    SET cost_optimization_enabled = (KHAMEL83_COST_OPTIMIZATION env var is true)
    IF has_khamel83 AND user mentions cost/budget/optimization:
      ENABLE: Khamel83 cost optimization mode
    USE: These settings throughout workflow execution
  </check_once>
</integration_detection>

## Integration Points

### 1. Project Lifecycle Integration

#### Start Project Enhancement
**When user starts a new project or analyzes existing:**

<conditional_execution>
  IF has_khamel83 templates:
    OFFER: "I can set up cost optimization using your Khamel83 templates. This typically achieves 90%+ cost savings through intelligent task breakdown and model routing."
    
    IF user accepts:
      EXECUTE: @templates/.khamel83/project-lifecycle/start-project.md
      SETUP: Cost tracking and pattern cache
      CONFIGURE: LiteLLM routing for three-phase optimization
</conditional_execution>

#### Resume Project Enhancement
**When user resumes work:**

<conditional_execution>
  IF .khamel83 directory exists in project:
    AUTOMATICALLY: Use @templates/.khamel83/project-lifecycle/resume-project.md
    ANALYZE: Current cost tracking status
    SUGGEST: Next tasks based on cost optimization patterns
</conditional_execution>

#### End Project Enhancement
**When project completion detected:**

<conditional_execution>
  IF cost tracking data exists:
    AUTOMATICALLY: Use @templates/.khamel83/project-lifecycle/end-project.md
    GENERATE: Final cost analysis report
    UPDATE: Pattern library with successful optimizations
</conditional_execution>

### 2. Task Execution Enhancement

#### Plan-Product Integration
**Enhance plan-product.md with cost awareness:**

<cost_optimization_layer>
  AFTER: Standard plan-product execution
  IF has_khamel83:
    CREATE: .khamel83/cost-tracking.json
    INITIALIZE: Pattern cache structure
    SET: Budget targets based on project complexity
    DOCUMENT: Cost optimization strategy in decisions.md
</cost_optimization_layer>

#### Create-Spec Integration
**Enhance create-spec.md with task breakdown:**

<spec_enhancement>
  DURING: Technical specification creation
  IF has_khamel83:
    ANALYZE: Spec complexity for cost optimization opportunities
    APPLY: Task breakdown template from @templates/.khamel83/cost-optimization/task-breakdown.md
    ESTIMATE: Traditional vs optimized costs
    DOCUMENT: Cost optimization strategy in spec
</spec_enhancement>

#### Execute-Tasks Integration
**Enhance execute-tasks.md with three-phase optimization:**

<execution_enhancement>
  BEFORE: Task execution begins
  IF has_khamel83:
    ANALYZE: Task complexity and optimization opportunities
    APPLY: Three-phase model (planning/implementation/review)
    ROUTE: Tasks through appropriate cost tier models
    TRACK: Actual costs vs estimates in real-time
    
  DURING: Task execution
    USE: Minimal context for implementation tasks
    APPLY: Pattern matching from cache
    BATCH: Similar micro-tasks when possible
    
  AFTER: Task completion
    UPDATE: Cost tracking data
    CACHE: Successful patterns
    ANALYZE: Optimization effectiveness
</execution_enhancement>

### 3. Cost Optimization Commands

#### /optimize-costs Command
**New command for manual cost optimization:**

<command_definition>
  COMMAND: /optimize-costs [task-description]
  DESCRIPTION: Apply Khamel83 cost optimization to any task
  
  PROCESS:
    1. ANALYZE: Task complexity and requirements
    2. APPLY: @templates/.khamel83/cost-optimization/task-breakdown.md
    3. ESTIMATE: Cost savings potential
    4. EXECUTE: Optimized task breakdown
    5. TRACK: Results in savings tracker
</command_definition>

#### /cost-report Command
**Generate cost optimization reports:**

<command_definition>
  COMMAND: /cost-report [period]
  DESCRIPTION: Generate cost optimization analysis
  
  PROCESS:
    1. READ: Cost tracking data from .khamel83/cost-tracking.json
    2. ANALYZE: Savings patterns and effectiveness
    3. GENERATE: Report using @templates/.khamel83/cost-optimization/savings-tracker.md
    4. SUGGEST: Optimization improvements
</command_definition>

#### /pattern-cache Command  
**Manage pattern library:**

<command_definition>
  COMMAND: /pattern-cache [action] [pattern-name]
  DESCRIPTION: Manage cost optimization patterns
  
  ACTIONS:
    - list: Show cached patterns
    - add: Add new pattern from current task
    - apply: Apply existing pattern to task
    - analyze: Show pattern effectiveness
</command_definition>

### 4. Automatic Detection & Suggestions

#### Cost Optimization Triggers
**Automatically suggest optimization when:**

<trigger_conditions>
  - Task estimated cost > $5.00
  - Similar task patterns exist in cache
  - User mentions budget constraints
  - Project has >10 similar tasks
  - Previous optimizations showed >80% savings
</trigger_conditions>

<suggestion_template>
  "I notice this task could benefit from cost optimization. Based on similar tasks, I can potentially reduce costs by [PERCENTAGE]% using the three-phase approach:
  
  - Planning Phase: $[AMOUNT] (detailed architecture)  
  - Implementation Phase: $[AMOUNT] (micro-tasks with cheap models)
  - Review Phase: $[AMOUNT] (quality assurance)
  
  Total estimated cost: $[AMOUNT] vs $[TRADITIONAL_AMOUNT] traditional
  
  Would you like me to apply cost optimization?"
</suggestion_template>

#### Pattern Matching Automation
**Automatically apply patterns when:**

<pattern_application>
  IF task matches cached pattern:
    SUGGEST: "I found a similar pattern that saved [PERCENTAGE]% on [PREVIOUS_TASK]. Apply this optimization?"
    
  IF pattern applied:
    TRACK: Pattern reuse success rate
    UPDATE: Pattern effectiveness metrics
    SUGGEST: Batch processing for similar upcoming tasks
</pattern_application>

### 5. Integration with External Tools

#### Ralex Integration
**If Ralex is available:**

<ralex_integration>
  CHECK: RALEX_ENDPOINT environment variable
  IF available:
    ROUTE: Task analysis through Ralex
    USE: Ralex model selection recommendations
    TRACK: Ralex routing effectiveness
    SYNC: Pattern library with Ralex cache
</ralex_integration>

#### LiteLLM Integration
**Automatic configuration:**

<litellm_setup>
  IF templates/.khamel83/model-routing/litellm-config.yaml exists:
    COPY: Config to project root (if not exists)
    CONFIGURE: Model routing for three-phase optimization
    ENABLE: Cost tracking and budget alerts
</litellm_setup>

## Usage Examples

### Example 1: Automatic Cost Optimization
```
User: "Create a user authentication system"

Agent OS Response:
"I can create this authentication system using cost optimization. 
Based on similar tasks, I estimate:

Traditional approach: ~$45-50
Optimized approach: ~$2-3 (95% savings)

Breakdown:
- Planning (Claude 3.5): $1.50 - Architecture & security design
- Implementation (GPT-3.5): $0.30 - 6 micro-tasks  
- Review (Claude Haiku): $0.40 - Security audit & testing

Shall I proceed with the optimized approach?"
```

### Example 2: Pattern Recognition
```
User: "Add a new API endpoint for posts"

Agent OS Response:
"I found a similar pattern from your user endpoints that saved 94%. 
I can apply this pattern and estimate:

- Using cached API endpoint pattern
- Implementation: $0.05 (micro-task)
- No planning needed (using existing architecture)  
- Quick review: $0.10

Total: $0.15 vs $8-12 traditional approach
Apply this optimization?"
```

### Example 3: Batch Optimization
```
User: "Create endpoints for users, posts, and comments"

Agent OS Response:
"I can batch these similar tasks for additional savings:

Individual optimization: 3 × $0.15 = $0.45
Batch optimization: $0.25 (shared context, pattern reuse)

Additional 44% savings through batching.
Shall I create all three endpoints together?"
```

## Configuration Options

### Environment Variables
```bash
# Enable Khamel83 cost optimization
export KHAMEL83_COST_OPTIMIZATION=true

# Set default budgets
export KHAMEL83_DAILY_BUDGET=10.00
export KHAMEL83_PLANNING_BUDGET=2.00
export KHAMEL83_IMPLEMENTATION_BUDGET=5.00
export KHAMEL83_REVIEW_BUDGET=3.00

# Pattern cache settings
export KHAMEL83_PATTERN_CACHE_ENABLED=true
export KHAMEL83_PATTERN_REUSE_THRESHOLD=0.80

# Ralex integration
export RALEX_ENDPOINT=http://localhost:8000
export RALEX_ENABLED=true
```

### Project Configuration
**Create `.khamel83/config.yaml` for project-specific settings:**

```yaml
cost_optimization:
  enabled: true
  aggressive_mode: false  # More aggressive micro-task breakdown
  
budgets:
  daily: 10.00
  planning: 0.10      # 10% of daily budget
  implementation: 0.70 # 70% of daily budget  
  review: 0.20        # 20% of daily budget
  
patterns:
  auto_apply: true
  reuse_threshold: 0.80
  cache_successful: true
  
ralex:
  enabled: true
  endpoint: "http://localhost:8000"
  fallback_enabled: true
```

## Monitoring & Analytics

### Real-time Cost Tracking
**During task execution:**
- Display running cost total
- Show percentage of budget used
- Alert when approaching budget limits
- Suggest optimizations for expensive tasks

### Pattern Library Analytics
**Track pattern effectiveness:**
- Success rate by pattern type
- Cost savings per pattern application
- Pattern reuse frequency
- Quality scores for pattern-generated code

### Optimization Recommendations
**Continuous improvement suggestions:**
- Identify tasks suitable for more aggressive optimization
- Suggest new patterns based on recurring tasks
- Recommend batch processing opportunities
- Highlight optimization successes for motivation

---

## Implementation Notes

This integration layer should be automatically activated when:
1. `templates/.khamel83` directory exists
2. User mentions cost, budget, or optimization
3. Environment variable `KHAMEL83_COST_OPTIMIZATION=true`

The integration enhances rather than replaces existing Agent OS workflows, maintaining full compatibility while adding cost optimization intelligence.

---

*This integration enables seamless cost optimization across all Agent OS workflows, typically achieving 90%+ cost savings through intelligent task decomposition and model routing.*