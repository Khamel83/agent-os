#!/bin/bash

# Khamel83 Agent OS Cost Optimization Installation Script
# This script activates the Khamel83 enhancements for cost optimization

set -e

echo "🚀 Installing Khamel83 Agent OS Cost Optimization Enhancements..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if we're in an Agent OS project or installing globally
if [ -d ".agent-os" ]; then
    INSTALL_MODE="project"
    INSTALL_DIR="."
    echo "📁 Detected Agent OS project - installing project-specific enhancements"
elif [ -d "$HOME/.agent-os" ]; then
    INSTALL_MODE="global"
    INSTALL_DIR="$HOME/.agent-os"
    echo "🌍 Installing global Khamel83 enhancements"
else
    print_error "Agent OS not detected. Please run this in an Agent OS project or after installing Agent OS globally."
    exit 1
fi

# Create Khamel83 directory structure
echo "📂 Creating Khamel83 template structure..."

if [ "$INSTALL_MODE" = "project" ]; then
    # Project installation
    mkdir -p .khamel83/{pattern-cache,cost-tracking}
    
    # Copy templates if they don't exist locally
    if [ ! -d "templates/.khamel83" ]; then
        print_warning "Khamel83 templates not found locally. This should be run from the Agent OS repository."
        exit 1
    fi
    
    print_status "Project directory structure created"
else
    # Global installation  
    mkdir -p "$HOME/.agent-os/templates/.khamel83"
    cp -r templates/.khamel83/* "$HOME/.agent-os/templates/.khamel83/"
    print_status "Global Khamel83 templates installed"
fi

# Initialize cost tracking
echo "💰 Setting up cost tracking..."

if [ "$INSTALL_MODE" = "project" ]; then
    # Create project cost tracking file
    cat > .khamel83/cost-tracking.json << EOF
{
  "project": "$(basename $(pwd))",
  "start_date": "$(date +%Y-%m-%d)",
  "budget": {
    "total": 0,
    "planning": 0,
    "implementation": 0,
    "review": 0
  },
  "savings": {
    "target_percent": 90,
    "actual_percent": 0,
    "total_saved": 0
  },
  "tasks": []
}
EOF

    # Create pattern cache index
    cat > .khamel83/pattern-cache/README.md << EOF
# Pattern Cache

This directory stores successful cost optimization patterns for reuse.

## Structure
- \`task-breakdowns/\` - Successful task decomposition patterns
- \`model-selections/\` - Effective model routing decisions  
- \`cost-savings/\` - Documented cost optimization successes
- \`integration-patterns/\` - Reusable integration solutions

## Usage
Patterns are automatically cached when tasks complete successfully.
Reference patterns by name in future tasks for cost optimization.
EOF

    print_status "Project cost tracking initialized"
fi

# Set up LiteLLM configuration
echo "🔧 Configuring model routing..."

if [ "$INSTALL_MODE" = "project" ] && [ ! -f "litellm-config.yaml" ]; then
    if [ -f "templates/.khamel83/model-routing/litellm-config.yaml" ]; then
        cp templates/.khamel83/model-routing/litellm-config.yaml litellm-config.yaml
        print_status "LiteLLM configuration installed"
    else
        print_warning "LiteLLM config template not found"
    fi
fi

# Add environment variables to .env if it exists
echo "🔧 Configuring environment variables..."

ENV_VARS="
# Khamel83 Cost Optimization
KHAMEL83_COST_OPTIMIZATION=true
KHAMEL83_DAILY_BUDGET=10.00
KHAMEL83_PATTERN_CACHE_ENABLED=true
KHAMEL83_PATTERN_REUSE_THRESHOLD=0.80
"

if [ -f ".env" ]; then
    if ! grep -q "KHAMEL83_COST_OPTIMIZATION" .env; then
        echo "$ENV_VARS" >> .env
        print_status "Environment variables added to .env"
    else
        print_warning "Khamel83 environment variables already exist in .env"
    fi
elif [ "$INSTALL_MODE" = "project" ]; then
    echo "$ENV_VARS" > .env
    print_status "Created .env with Khamel83 configuration"
fi

# Create quick access commands
echo "⚡ Creating quick access commands..."

if [ "$INSTALL_MODE" = "project" ]; then
    cat > khamel83-commands.sh << 'EOF'
#!/bin/bash
# Khamel83 Quick Commands

khamel83_start_project() {
    echo "🚀 Starting project with cost optimization..."
    cat templates/.khamel83/project-lifecycle/start-project.md
}

khamel83_resume_project() {
    echo "🔄 Resuming project..."
    cat templates/.khamel83/project-lifecycle/resume-project.md
}

khamel83_end_project() {
    echo "🏁 Ending project with full handover..."
    cat templates/.khamel83/project-lifecycle/end-project.md
}

khamel83_cost_report() {
    echo "📊 Current cost optimization status:"
    if [ -f ".khamel83/cost-tracking.json" ]; then
        cat .khamel83/cost-tracking.json | jq '.'
    else
        echo "No cost tracking data found. Start a task to begin tracking."
    fi
}

khamel83_optimize_task() {
    echo "💡 Task optimization template:"
    cat templates/.khamel83/cost-optimization/task-breakdown.md
}

# Make functions available
alias k83-start='khamel83_start_project'
alias k83-resume='khamel83_resume_project'  
alias k83-end='khamel83_end_project'
alias k83-report='khamel83_cost_report'
alias k83-optimize='khamel83_optimize_task'

echo "Khamel83 commands loaded! Available aliases:"
echo "  k83-start    - Start project workflow"
echo "  k83-resume   - Resume project workflow"
echo "  k83-end      - End project workflow"
echo "  k83-report   - Show cost report"
echo "  k83-optimize - Show task optimization template"
EOF

    chmod +x khamel83-commands.sh
    print_status "Quick commands created (source khamel83-commands.sh to use)"
fi

# Verify installation
echo "🔍 Verifying installation..."

ERRORS=0

if [ "$INSTALL_MODE" = "project" ]; then
    # Project verification
    [ -d ".khamel83" ] || { print_error "Cost tracking directory not created"; ERRORS=$((ERRORS+1)); }
    [ -f ".khamel83/cost-tracking.json" ] || { print_error "Cost tracking file not created"; ERRORS=$((ERRORS+1)); }
    [ -d "templates/.khamel83" ] || { print_error "Khamel83 templates not found"; ERRORS=$((ERRORS+1)); }
else
    # Global verification  
    [ -d "$HOME/.agent-os/templates/.khamel83" ] || { print_error "Global templates not installed"; ERRORS=$((ERRORS+1)); }
fi

if [ $ERRORS -eq 0 ]; then
    print_status "Installation verified successfully"
else
    print_error "$ERRORS errors found during verification"
    exit 1
fi

echo ""
echo "🎉 Khamel83 Cost Optimization Installation Complete!"
echo ""
echo "📖 What was installed:"
echo "   • Cost optimization templates and workflows"
echo "   • Three-phase development model (Planning/Implementation/Review)"  
echo "   • Pattern caching system for reuse"
echo "   • Project lifecycle management (start/resume/end)"
echo "   • Model routing configuration"
echo ""
echo "💡 Next steps:"
if [ "$INSTALL_MODE" = "project" ]; then
    echo "   1. Source quick commands: source khamel83-commands.sh"
    echo "   2. Start optimized development: k83-start"
    echo "   3. Apply optimization to tasks: k83-optimize"
    echo "   4. Track your savings: k83-report"
else
    echo "   1. Navigate to an Agent OS project"
    echo "   2. Run: bash ~/.agent-os/install-khamel83.sh"
    echo "   3. Start using cost optimization in your projects"
fi
echo ""
echo "🎯 Target: 90%+ cost savings through intelligent task breakdown"
echo "📚 Learn more: Read KHAMEL83_ENHANCEMENTS.md"
echo ""
echo "Happy cost-optimized coding! 🚀💰"